import Foundation

struct PostBestByDateRequest: ApiRequestTemplate {
    typealias Response = PostBestByDateResponse
    
    var baseUrlType: BaseUrlType = .bestByDateRequest

    var path: String {
        "/best-by-date-info"
    }

    var method: HttpMethod {
        .post
    }

    var bodyParams: [String: Any?]?

    var headerParams: [String: String] {
        [
            "": ""
        ]
    }
    
    init(groupInfo: [BestByDateInfo]) {
        bodyParams = ["group_info": groupInfo.map {
            return [
                "id": $0.id ?? -1,
                "name": $0.name,
                "best_by_date": $0.bestByDate,
                "notify_flag": $0.nofityFlag ?? true
            ] as [String : Any]
        }]
    }
}

struct PostBestByDateResponse: Decodable {
}
