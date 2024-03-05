import Foundation

enum BaseUrlType {

    case bestByDateRequest

    var urlString: String {
        switch self {
        case .bestByDateRequest:
            return "https://wn75atzolc.execute-api.ap-northeast-1.amazonaws.com/develop"
        }
    }
}
