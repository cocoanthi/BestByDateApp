import Foundation

enum ApiRequestError: Error, Equatable {
    case unexpected
    case decodingFailed
    case notFound
    case errorResponse(message: String)
    case parameterError
    case timeOut

    var message: String {
        switch self {
        case .unexpected, .decodingFailed, .notFound, .parameterError, .timeOut:
            return "エラーが発生しました"
        case let .errorResponse(message):
            return message
        }
    }
}

extension ApiRequestError {
    static func from(statusCode: Int) -> ApiRequestError {
        switch statusCode {
        case 400:
            return .parameterError
        case 404:
            return .notFound
        case 500:
            return .unexpected
        default:
            return .decodingFailed
        }
    }

    var caseName: String {
        let mirror = Mirror(reflecting: self)
        return mirror.children.first?.label ?? "\(self)"
    }
}
