import SwiftUI

class BestByDateViewModel: ObservableObject {
    /// 画面表示用Item
    @Published var viewBestByDateItemList: [BestByDateItem] = []
    @Published var isLoading: Bool = false
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
        Task {
            await updateListRequest()
        }
    }
    
    /* View Action */
    
    func addItemButtonTapped() {
        let addItem = {
            withAnimation {
                let newItem = BestByDateItem(
                    groupId: self.groupInfo.groupId,
                    serverId: nil,
                    name: "",
                    bestByDate: Date(),
                    notifyFlag: 1,
                    state: .created
                )
                self.viewBestByDateItemList.append(newItem)
            }
        }
        
        if viewBestByDateItemList.isEmpty {
            addItem()
        } else if let lastItem = viewBestByDateItemList.last, !lastItem.name.isEmpty {
            addItem()
        }
    }
    
    func notifyToggleTapped(index: Int) {
        viewBestByDateItemList[index].notifyFlag = viewBestByDateItemList[index].notifyFlag == 1 ? 0 : 1
    }
    
    func notifyButtonTapped() -> [String] {
        // TODO: 一旦全て消してから全て登録し直す。差分のみ更新した方が良い場合は対応する
        NotificationManager.instance.deleteAllNotification()
        let target = createNotificationInfo()
        NotificationManager.instance.sendNotification(notificationInfoList: target)
        
        var targetNames: [String] = []
        for info in target {
            if info.isNotify {
                targetNames.append(info.title)
            }
        }
        return targetNames
    }
    
    func deleteButtonTapped(index: Int) {
        if viewBestByDateItemList[safe: index] != nil {
            viewBestByDateItemList.remove(at: index)
        }
    }
    
    func onChangeItem(index: Int) {
        // 作成されたItemが変更された場合はupdatedではなくcreatedの状態を継続する
        guard viewBestByDateItemList[index].state != .created else { return }
        viewBestByDateItemList[index].state = .updated
    }
    
    func copyButtonTapped(str: String) {
        UIPasteboard.general.string = str
    }
    
    func updateButtonTapped() {
        self.isLoading = true
        Task {
            defer {
                resetBestByDateItemState()
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
            var result = ["update":false, "insert":false, "delete":false]
            /// update処理
            let updateList = viewBestByDateItemList.filter { $0.state == .updated }.map {
                return BestByDateInfo(groupId: $0.groupId, id: $0.serverId, name: $0.name, bestByDate: $0.bestByDate, notifyFlag: $0.notifyFlag)
            }
            print("updateList = \(updateList)")
            if !updateList.isEmpty {
                result["update"] = try? await BestByDateRepository.shared.update(from: .init(groupInfo: updateList))
            } else {
                result["update"] = true
            }
            
            /// insert処理
            let insertList = viewBestByDateItemList.filter { $0.state == .created }.map {
                return BestByDateInfo(groupId: $0.groupId, id: $0.serverId, name: $0.name, bestByDate: $0.bestByDate, notifyFlag: $0.notifyFlag)
            }
            print("insertList = \(insertList)")
            if !insertList.isEmpty {
                result["insert"] = try? await BestByDateRepository.shared.insert(from: .init(groupInfo: insertList))
            } else {
                result["insert"] = true
            }
            /// delete処理
            var deleteList = oldBestByDateItemList
            // deleteListとviewBestByDateItemListのidを比較して、マッチした情報をoldから削除していく。最終的にoldに残った情報が削除情報になる
            for viewValue in viewBestByDateItemList {
                deleteList.removeAll(where: {$0.id == viewValue.id})
            }
            print("deleteList = \(deleteList)")
            if !deleteList.isEmpty {
                result["delete"] = try? await BestByDateRepository.shared.delete(from: .init(id: deleteList.compactMap { return $0.serverId }))
            } else {
                result["delete"] = true
            }
            
            let failedProcess = result.filter { $0.value == false }
            print("failedProcess \(failedProcess)")

            await updateListRequest()
        }
    }
    
    /* private method */

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
    
    private func resetBestByDateItemState() {
        DispatchQueue.main.async {
            for index in 0..<self.viewBestByDateItemList.count {
                if self.viewBestByDateItemList[safe: index] != nil {
                    self.viewBestByDateItemList[index].state = .none
                }
            }
        }
    }
    
    private func updateListRequest() async {
        Task {
            do {
                let info = try await BestByDateRepository.shared.fetch(from: .init(groupId: groupInfo.groupId))
                DispatchQueue.main.async {
                    self.viewBestByDateItemList.removeAll()
                    self.viewBestByDateItemList.append(contentsOf: info.map({ bestByDateInfo in
                        return BestByDateItem(
                            groupId: bestByDateInfo.groupId,
                            serverId: bestByDateInfo.id,
                            name: bestByDateInfo.name,
                            bestByDate: bestByDateInfo.bestByDate,
                            notifyFlag: bestByDateInfo.notifyFlag
                        )
                    }))
                    self.oldBestByDateItemList = self.viewBestByDateItemList
                }
            } catch {
                print(error)
            }
        }
    }
}
