import Foundation

struct PostBestByDateRequest: ApiRequestTemplate {
    typealias Response = EmptyResponse
    
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
    
    private var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter
    }

    init(groupInfo: [BestByDateInfo]) {
        bodyParams = ["best_by_date_info": groupInfo.map {
            return [
                "id": $0.id ?? -1,
                "name": $0.name,
                "best_by_date": formatter.string(from: $0.bestByDate),
                "notify_flag": $0.notifyFlag
            ] as [String : Any]
        }]
    }
}
