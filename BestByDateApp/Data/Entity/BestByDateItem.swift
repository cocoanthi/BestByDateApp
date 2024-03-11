import Foundation

/// 消費/賞味期限情報
struct BestByDateItem: Identifiable {
    let id = UUID()
    let groupId: Int
    var name: String
    var bestByDate: Date
    var notifyFlag: Bool
}
