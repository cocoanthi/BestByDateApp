import Foundation
import UserNotifications

final class NotificationManager {
    static let instance: NotificationManager = NotificationManager()
    
    /// 権限リクエスト
    func requestPermission() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { (granted, _) in
                print("Permission granted: \(granted)")
            }
    }
    
    func sendNotification(notificationInfoList: [NotificationInfo]) {
        notificationInfoList.forEach { info in
            guard info.isNotify else { return }
            let content = UNMutableNotificationContent()
            content.title = info.title
            content.body = info.body
            let trigger = UNTimeIntervalNotificationTrigger(
                // 引数の値が不正の場合はクラッシュするため10秒後通知とする
                timeInterval: TimeInterval(info.timeInterval > 0 ? info.timeInterval : 10),
                repeats: info.isRepeat
            )
            let request = UNNotificationRequest(identifier: info.identifier, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }
        
    func deleteAllNotification() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
    }
}

struct NotificationInfo {
    let identifier: String
    let title: String
    let body: String
    let timeInterval: Int
    let isRepeat: Bool
    let isNotify: Bool
}


