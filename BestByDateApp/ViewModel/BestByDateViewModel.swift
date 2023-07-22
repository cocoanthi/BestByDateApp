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
                    timeInterval: createTimeInterval(notificationDate: item.bestByDate),
                    isRepeat: false,
                    isNotify: item.isNotify
                )
            )
        }
        return notificationInfo
    }

    /// Push通知する時間を生成する
    /// 期限の3日前 10:00に設定。処理失敗時は-1を返す
    private func createTimeInterval(notificationDate: Date) -> Int {
        let today = Date()
        guard let bestByDateTimeInterval = dateFormatter.date(from: dateFormatter.string(from: notificationDate))?.timeIntervalSince1970,
              let nowDateTimeInterval = dateFormatter.date(from: dateFormatter.string(from: today))?.timeIntervalSince1970 else {
            return -1
        }
        print("bestByDateTimeInterval - nowDateTimeInterval = \(String(describing: bestByDateTimeInterval - nowDateTimeInterval))")
        // 何日前に通知するか
        // TODO: ここでは現状仕様として3日前
        let notifyDayToSec = (60 * 60 * 24) * 3
        // 通知したい時間(秒)
        // TODO: ここでは現状仕様として10時としている
        let notifyTimeToSec = 60 * 60 * 10
        // 現在時間→秒
        let currentTimeToSec = (Calendar.current.component(.hour, from: today) * 60 * 60) + (Calendar.current.component(.minute, from: today) * 60)
        print("\(String(describing: Int(bestByDateTimeInterval - nowDateTimeInterval) - notifyDayToSec + notifyTimeToSec - currentTimeToSec))")

        // (期限日 - 今日 - 通知したい日) + 通知したい時間 - 現在時間
        return (Int(bestByDateTimeInterval - nowDateTimeInterval) - notifyDayToSec) + notifyTimeToSec - currentTimeToSec
    }
}
