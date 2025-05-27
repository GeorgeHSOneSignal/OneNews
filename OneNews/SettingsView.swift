//
//  SettingsView.swift
//  OneNews
//
//  Created by George Hitchman-Smith on 27/05/2025.
//


import SwiftUI
import OneSignalFramework

struct SettingsView: View {
    @State private var appId: String = UserDefaults.standard.string(forKey: "OneSignalAppId") ?? ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("OneSignal App ID")) {
                    TextField("Enter OneSignal App ID", text: $appId)
                }

                Button("Save App ID") {
                    UserDefaults.standard.set(appId, forKey: "OneSignalAppId")
                    OneSignal.initialize(appId)
                    OneSignal.Notifications.requestPermission({ accepted in
                      print("User accepted notifications: \(accepted)")
                    }, fallbackToSettings: false)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
