import Foundation

/// 消費/賞味期限情報
struct BestByDateItem: Identifiable {
    var id = UUID()
    var name: String
    var bestByDate: Date
    var isNotify: Bool = true
}
