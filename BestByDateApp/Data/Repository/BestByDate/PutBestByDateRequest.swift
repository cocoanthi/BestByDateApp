import Foundation

struct PutBestByDateRequest: ApiRequestTemplate {
    typealias Response = PutBestByDateResponse
    
    var baseUrlType: BaseUrlType = .bestByDateRequest

    var path: String {
        "/best-by-date-info"
    }

    var method: HttpMethod {
        .put
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
                "group_id": $0.groupId,
                "name": $0.name,
                "best_by_date": $0.bestByDate,
                "notify_flag": $0.nofityFlag ?? true
            ] as [String : Any]
        }]
    }
}

struct PutBestByDateResponse: Decodable {
}
