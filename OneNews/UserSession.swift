// UserSession.swift

import SwiftUI
import OneSignalFramework

struct User: Codable, Identifiable {
    var id = UUID()
    let email: String
    let firstName: String
    let lastName: String
    let phone: String
    let accountType: String
}


class UserSession: ObservableObject {
    @Published var currentUser: User? = nil
    @Published var subscribedCategories: Set<String> = []
    @Published var likedArticles: Set<UUID> = [] {
        didSet {
            saveUUIDSet(likedArticles, forKey: "likedArticles")
        }
    }
    @Published var savedArticles: Set<UUID> = [] {
        didSet {
            saveUUIDSet(savedArticles, forKey: "savedArticles")
        }
    }
    @Published var shouldResetNavigation = false
    @Published var isLoggedIn: Bool = false

    
    init() {
        loadUserFromDefaults()
        self.likedArticles = loadUUIDSet(forKey: "likedArticles")
        self.savedArticles = loadUUIDSet(forKey: "savedArticles")
        fetchUserTags()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.syncOneSignalLoginState()
        }
    }
    func syncOneSignalLoginState() {
        guard isLoggedIn, let email = currentUser?.email else {
            print("Not logged in or email missing — skipping OneSignal sync.")
            return
        }

        let currentExternalId = OneSignal.User.externalId

        if currentExternalId != email {
            print("Syncing OneSignal login: expected \(email), actual \(currentExternalId ?? "nil")")
            OneSignal.login(email)
        } else {
            print("OneSignal already logged in as \(email)")
        }
    }


    
    func syncSubscribedCategoriesFromOneSignal() {
        fetchUserTags()
        print("getting tags")
    }
    
    func fetchUserTags() {
        let tags = OneSignal.User.getTags()
        let savedCategories = tags.keys.filter { $0.starts(with: "category_") }
        DispatchQueue.main.async {
            for categoryKey in savedCategories {
                let category = categoryKey.replacingOccurrences(of: "category_", with: "")
                self.subscribedCategories.insert(category)
            }
        }
        print(tags)
    }



    
    
    func login(email: String, firstName: String, lastName: String, phone: String) {
        let user = User(
            email: email,
            firstName: firstName,
            lastName: lastName,
            phone: phone,
            accountType: "Demo"
        )
        self.currentUser = user
        saveUserToDefaults(user)
    }

    func logout() {
        currentUser = nil
        UserDefaults.standard.removeObject(forKey: userKey)
    }
    
    private let userKey = "currentUser"

    func saveUserToDefaults(_ user: User) {
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: userKey)
        }
    }

    func loadUserFromDefaults() {
        if let data = UserDefaults.standard.data(forKey: userKey),
           let decoded = try? JSONDecoder().decode(User.self, from: data) {
            self.currentUser = decoded
        }
    }

    private func saveUUIDSet(_ set: Set<UUID>, forKey key: String) {
        let strings = set.map { $0.uuidString }
        UserDefaults.standard.set(strings, forKey: key)
    }

    private func loadUUIDSet(forKey key: String) -> Set<UUID> {
        let strings = UserDefaults.standard.stringArray(forKey: key) ?? []
        return Set(strings.compactMap { UUID(uuidString: $0) })
    }

}



