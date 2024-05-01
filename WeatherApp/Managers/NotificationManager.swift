//
//  NotificationManager.swift
//  WeatherApp
//
//  Created by 정현 on 5/1/24.
//

import Foundation
import UserNotifications

struct Notification {
    var id : String
    var title : String
    var body : String
}

class NotificationManager {
    var notifications = [Notification]()
    
    // MARK: - 알림권한 설정
    func requestPermission() -> Void {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert,.badge]) { granted, error in
                if granted == true && error == nil{
                    
                }
            }
    }
    
    // MARK: - 알림추가
    func addNotification(title : String, body : String) {
        notifications.append(Notification(id: UUID().uuidString, title: title,body:body))
    }
    
    // MARK: - 알림메시지 설정
    func scheduleNotifications() {
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = notification.title
            content.body = notification.body
            
            var date = DateComponents()
            date.hour = 19
            date.minute = 55
            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
            let request = UNNotificationRequest(identifier: notification.id, content: content,trigger: trigger)
            
            UNUserNotificationCenter
                .current()
                .add(request) { error in
                    guard error == nil else {return}
                    print("Scheduling notification : \(notification.id)")
                }
        }
    }
}
