import Foundation

struct BestByDateInfo: Decodable {
    let groupId: String
    let id: Int?
    let name: String
    let bestByDate: Date
    let notifyFlag: Int
    
    var isNotify: Bool {
        notifyFlag == 1
    }
}
