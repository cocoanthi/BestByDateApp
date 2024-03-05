import Combine
import Foundation

class ApiRequestPublisher<T: ApiRequestTemplate> {
    let baseUrl: String
    let baseUrlType: BaseUrlType
    let path: String
    let method: HttpMethod
    var bodyParams: [String: Any?]?
    var headerParams: [String: String]

    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Locale(identifier: "ja_JP")
        decoder.dateDecodingStrategy = .formatted(formatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    init(
        baseUrl: String,
        baseUrlType: BaseUrlType,
        path: String,
        method: HttpMethod,
        bodyParams: [String: Any?]?,
        headerParams: [String: String]
    ) {
        self.baseUrl = baseUrl
        self.baseUrlType = baseUrlType
        self.path = path
        self.method = method
        self.bodyParams = bodyParams
        self.headerParams = headerParams
    }

    func publish() -> AnyPublisher<T.Response, ApiRequestError> {
        guard let url = URL(string: baseUrl + path),
              let urlRequest = makeUrlRequest(url: url) else {
            return Fail(error: .unexpected).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { output -> T.Response in
                guard let httpResponse = output.response as? HTTPURLResponse else {
                    throw ApiRequestError.unexpected
                }
                print("URL = \(url)")
                print("statusCode = \(httpResponse.statusCode)")
                if 200..<300 ~= httpResponse.statusCode {
                    if let response = self.convertToResponse(data: output.data) {
                        return response
                    }
                    throw ApiRequestError.decodingFailed
                }
                throw ApiRequestError.from(statusCode: httpResponse.statusCode)
            }
            .mapError { error in
                let requestError: ApiRequestError
                switch error {
                case let apiRequestError as ApiRequestError:
                    requestError = apiRequestError
                case is Swift.DecodingError:
                    requestError = .decodingFailed
                case URLError.timedOut:
                    requestError = .timeOut
                default:
                    requestError = .unexpected
                }
                return requestError
            }
            .eraseToAnyPublisher()
    }

    private func makeUrlRequest(url: URL) -> URLRequest? {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        if let bodyParams = bodyParams {
            do {
                // 最上位階層がArrayであるデータパターンの対応: keyを空文字にした場合は、valueの先頭のみをbodyに入れる(map内は一件のみの想定)
                if let body = bodyParams[""] as? String {
                    urlRequest.httpBody = body.data(using: .utf8)
                } else {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: bodyParams, options: [])
                }
            } catch {
                return nil
            }
        }
        // DELETEメソッドでリクエストボディが必要なパターンに対応するため
        if method != .get {
            headerParams["charset"] = "UTF-8"
            if headerParams["Content-Type"] == nil {
                headerParams["Content-Type"] = "application/json"
            }
        }
        if !headerParams.isEmpty {
            urlRequest.allHTTPHeaderFields = headerParams
        }
        return urlRequest
    }

    private func convertToResponse(data: Data) -> T.Response? {
        if let response = EmptyResponse() as? T.Response ?? data as? T.Response {
            return response
        }
        return try? decoder.decode(T.Response.self, from: data)
    }
}
