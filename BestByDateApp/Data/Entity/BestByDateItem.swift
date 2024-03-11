import Foundation

/// 消費/賞味期限情報
struct BestByDateItem: Identifiable, Equatable {
    let id = UUID()
    let groupId: Int
    var name: String
    var bestByDate: Date
    var notifyFlag: Bool
    var state: ItemState = .none
    
    enum ItemState {
        case created
        case updated
        case deleted
        case none
    }
}
