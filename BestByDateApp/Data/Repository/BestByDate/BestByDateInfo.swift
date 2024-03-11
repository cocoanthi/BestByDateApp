import Foundation

struct BestByDateInfo: Decodable {
    // TODO: Stringに変更する
    let groupId: Int
    let id: Int
    let name: String
    let bestByDate: Date
    // TODO: うまくパースできない。おそらくdb側の問題なのであとで対応
    let nofityFlag: Bool?
}
