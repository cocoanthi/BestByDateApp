import SwiftUI

class BestByDateViewModel: ObservableObject {
    
    @Published var bestByDateItem: BestByDateItem? = nil
    @Published var bestByDateItemList: [BestByDateItem] = []
    
    var dateFormatter: DateFormatter {
        let format = DateFormatter()
        format.locale = Locale(identifier: "ja_JP")
        format.dateStyle = .medium
        format.dateFormat = "yyyy-MM-dd"
        return format
    }
    
    init() {
        let bestByDateItemList: [BestByDateItem] = [
            BestByDateItem(name: "砂糖", bestByDate: Date()),
            BestByDateItem(name: "塩", bestByDate: Date()),
            BestByDateItem(name: "酢", bestByDate: Date()),
            BestByDateItem(name: "醤油", bestByDate: Date()),
            BestByDateItem(name: "味噌", bestByDate: Date()),
            BestByDateItem(name: "マヨネーズ", bestByDate: Date()),
            BestByDateItem(name: "ケチャップ", bestByDate: Date())
        ]
        self.bestByDateItemList = bestByDateItemList
    }
    
    func addItem() {
        guard let lastItem = bestByDateItemList.last,
              !lastItem.name.isEmpty else { return }
        withAnimation {
            let newItem = BestByDateItem(name: "", bestByDate: Date())
            bestByDateItemList.append(newItem)
        }
    }
    
    func updateNotification() {
        // TODO: 一旦全て消してから全て登録し直す。差分のみ更新した方が良い場合は対応する
        NotificationManager.instance.deleteAllNotification()
        NotificationManager.instance.sendNotification(notificationInfoList: createNotificationInfo())
    }
    
    func deleteItems(offsets: IndexSet) {
        withAnimation {
            bestByDateItemList.remove(atOffsets: offsets)
        }
    }
    
    private func createNotificationInfo() -> [NotificationInfo] {
        var notificationInfo: [NotificationInfo] = []
        bestByDateItemList.forEach { item in
            notificationInfo.append(
                NotificationInfo(
                    identifier: item.id.uuidString,
                    title: item.name,
                    body: "",
                    timeInterval: 10,
                    isRepeat: false,
                    isNotify: item.isNotify
                )
            )
        }
        return notificationInfo
    }

}
