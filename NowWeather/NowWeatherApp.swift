//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by 정현 on 3/12/24.
//

import SwiftUI
import UIKit

class AppDelegate : UIResponder,UIApplicationDelegate, UNUserNotificationCenterDelegate{
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,willPresent notification: UNNotification,withCompletionHandler completionHadler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHadler([.badge,.sound])
        }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}


@main
struct WeatherAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
