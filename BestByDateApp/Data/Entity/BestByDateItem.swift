import Foundation

/// 消費/賞味期限情報
struct BestByDateItem: Identifiable, Equatable {
    let id = UUID()
    let groupId: Int
    var serverId: Int?
    var name: String
    var bestByDate: Date
    var notifyFlag: Int
    var state: ItemState = .none
    
    var isNotify: Bool {
        notifyFlag == 1
    }
    
    enum ItemState {
        case created
        case updated
        case deleted
        case none
    }
}
