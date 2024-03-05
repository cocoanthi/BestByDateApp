import Combine
import Foundation

protocol ApiRequestTemplate {
    associatedtype Response: Decodable

    var baseUrlType: BaseUrlType { get }
    var path: String { get }
    var method: HttpMethod { get }
    var bodyParams: [String: Any?]? { get }
    var headerParams: [String: String] { get }
}

extension ApiRequestTemplate {
    var headerParams: [String: String] {
        [:]
    }

    func publish() -> AnyPublisher<Response, ApiRequestError> {
        ApiRequestPublisher<Self>(
            baseUrl: baseUrlType.urlString,
            baseUrlType: baseUrlType,
            path: path,
            method: method,
            bodyParams: bodyParams,
            headerParams: headerParams
        ).publish()
    }
}
