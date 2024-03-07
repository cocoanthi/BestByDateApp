import Foundation

struct BestByDateInfo: Decodable {
    // TODO: Stringに変更する
    let groupId: Int
    let id: Int
    let name: String
    let bestByDate: Date
    let nofityFlag: Bool
}
