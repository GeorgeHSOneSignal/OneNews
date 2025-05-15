//
//  OneNewsApp.swift
//  OneNews
//
//  Created by George Hitchman-Smith on 14/05/2025.
//

import SwiftUI
import OneSignalFramework

@main
struct OneNewsApp: App {
    @StateObject private var session = UserSession()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            NewsListView()  // <- This is now your app’s launch screen
                .environmentObject(session) // 🔹 Inject UserSession globally
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      
       // Enable verbose logging for debugging (remove in production)
       OneSignal.Debug.setLogLevel(.LL_VERBOSE)
       // Initialize with your OneSignal App ID
       OneSignal.initialize("59ea98b1-26b6-4fe8-8ac9-803bdbf8ff99", withLaunchOptions: launchOptions)
       // Use this method to prompt for push notifications.
       // We recommend removing this method after testing and instead use In-App Messages to prompt for notification permission.
       OneSignal.Notifications.requestPermission({ accepted in
         print("User accepted notifications: \(accepted)")
       }, fallbackToSettings: false)
       return true
    }
}
