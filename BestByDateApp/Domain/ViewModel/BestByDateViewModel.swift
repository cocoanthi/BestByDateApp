import SwiftUI

class BestByDateViewModel: ObservableObject {
    /// 画面表示用Item
    @Published var viewBestByDateItemList: [BestByDateItem] = []
    let groupInfo: GroupInfo
    
    var dateFormatter: DateFormatter {
        let format = DateFormatter()
        format.locale = Locale(identifier: "ja_JP")
        format.dateStyle = .medium
        format.dateFormat = "yyyy-MM-dd"
        return format
    }
    /// API要求用Item
    private var oldBestByDateItemList: [BestByDateItem] = []
    
    init(groupInfo: GroupInfo) {
        self.groupInfo = groupInfo
        getBestByDateInfo(id: groupInfo.groupId) { result in
            switch result {
            case let .success(info):
                self.viewBestByDateItemList.append(contentsOf: info.map({ bestByDateInfo in
                    return BestByDateItem(
                        groupId: bestByDateInfo.groupId,
                        name: bestByDateInfo.name,
                        bestByDate: bestByDateInfo.bestByDate,
                        notifyFlag: bestByDateInfo.nofityFlag ?? true
                    )
                }))
                self.oldBestByDateItemList = self.viewBestByDateItemList
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func addItem() {
        guard let lastItem = viewBestByDateItemList.last,
              !lastItem.name.isEmpty else { return }
        withAnimation {
            let newItem = BestByDateItem(
                groupId: Int(groupInfo.groupId) ?? -1,
                name: "",
                bestByDate: Date(),
                notifyFlag: true,
                state: .created
            )
            viewBestByDateItemList.append(newItem)
        }
    }
    
    func updateNotification() {
        // TODO: 一旦全て消してから全て登録し直す。差分のみ更新した方が良い場合は対応する
        NotificationManager.instance.deleteAllNotification()
        NotificationManager.instance.sendNotification(notificationInfoList: createNotificationInfo())
    }
    
    func deleteItems(offsets: IndexSet) {
        withAnimation {
            viewBestByDateItemList.remove(atOffsets: offsets)
        }
    }
    
    func onChangeItem(index: Int) {
        // 作成されたItemが変更された場合はupdatedではなくcreatedの状態を継続する
        guard viewBestByDateItemList[index].state != .created else { return }
        viewBestByDateItemList[index].state = .updated
    }
    
    private func createNotificationInfo() -> [NotificationInfo] {
        var notificationInfo: [NotificationInfo] = []
        viewBestByDateItemList.forEach { item in
            notificationInfo.append(
                NotificationInfo(
                    identifier: item.id.uuidString,
                    title: item.name,
                    body: "",
                    timeInterval: createTimeInterval(notificationDate: item.bestByDate),
                    isRepeat: false,
                    isNotify: item.notifyFlag
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
        // 何日前に通知するか
        // TODO: ここでは現状仕様として3日前
        let notifyDayToSec = (60 * 60 * 24) * 3
        // 通知したい時間(秒)
        // TODO: ここでは現状仕様として10時としている
        let notifyTimeToSec = 60 * 60 * 10
        // 現在時間→秒
        let currentTimeToSec = (Calendar.current.component(.hour, from: today) * 60 * 60) + (Calendar.current.component(.minute, from: today) * 60)
        // 通知したい日までの秒数：(期限日 - 今日 - 通知したい日) + 通知したい時間 - 現在時間
        let notifyTimeInterval = (Int(bestByDateTimeInterval - nowDateTimeInterval) - notifyDayToSec) + notifyTimeToSec - currentTimeToSec
        print("\(notifyTimeInterval)")
        return notifyTimeInterval
    }
    
    private func getBestByDateInfo(
        id: String,
        completion: @escaping (Result<[BestByDateInfo], ApiRequestError>) -> Void
    ) {
        BestByDateRepository.shared.fetch(from: .init(groupId: id)) { result in
            return DispatchQueue.main.async {
                switch result {
                case let .success(info):
                    print("bestByDate.fetch succeed!")
                    return completion(.success(info))
                case let .failure(error):
                    print(error)
                    return completion(.failure(error))
                }
            }
        }
    }
}
