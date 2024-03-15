import Foundation

struct DeleteBestByDateRequest: ApiRequestTemplate {
    typealias Response = EmptyResponse
    
    var baseUrlType: BaseUrlType = .bestByDateRequest

    var path: String {
        "/best-by-date-info"
    }

    var method: HttpMethod {
        .delete
    }

    var bodyParams: [String: Any?]?

    var headerParams: [String: String] {
        [
            "": ""
        ]
    }
    
    init(id: [Int]) {
        bodyParams = [
            "id": [ id.map { return $0 } ]
        ]
    }
}
