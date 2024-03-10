import Foundation

struct GetBestByDateRequest: ApiRequestTemplate {
    typealias Response = GetBestByDateResponse

    let groupId: String
    
    var baseUrlType: BaseUrlType = .bestByDateRequest

    var path: String {
        "/best-by-date-info?group_id=\(groupId)"
    }

    var method: HttpMethod {
        .get
    }

    var bodyParams: [String: Any?]?

    var headerParams: [String: String] {
        [
            "": ""
        ]
    }
}

struct GetBestByDateResponse: Decodable {
    let bestByDateInfo: [BestByDateInfo]
}
