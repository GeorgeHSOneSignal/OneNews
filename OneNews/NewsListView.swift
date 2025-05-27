import SwiftUI
import OneSignalFramework

enum NavigationRoute: Hashable, Equatable {
    case login
    case article(Article)
    case account

    static func == (lhs: NavigationRoute, rhs: NavigationRoute) -> Bool {
        switch (lhs, rhs) {
        case (.login, .login):
            return true
        case (.article(let a1), .article(let a2)):
            return a1.id == a2.id
        default:
            return false
        }
    }
}

struct NewsListView: View {
    @EnvironmentObject var session: UserSession
    @State private var path: [NavigationRoute] = []
    @State private var savedArticles: Set<UUID> = []
    @State private var likedArticles: Set<UUID> = []
    @State private var showingSettings = false

    var body: some View {
        

        NavigationStack(path: $path) {
            List {
                // Logo at the top of the list
                HStack {
                    Spacer()
                    Image("onenews-logo") // Replace with your actual asset name
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .padding(.top, 16)
                    Spacer()
                }
                .listRowSeparator(.hidden)

                // List of articles
                ForEach(sampleArticles) { article in
                    Button {
                        path.append(.article(article))
                    } label: {
                        ArticleRow(article: article)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .listStyle(PlainListStyle())
            //.navigationTitle("Latest News")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if session.currentUser != nil {
                        Button("My Account") {
                            path.append(.account)
                        }
                    } else {
                        Button("Login") {
                            path.append(.login)
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showingSettings = true
                    }) {
                        Image(systemName: "gearshape")
                    }
                }
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView()
            }
            .navigationDestination(for: NavigationRoute.self) { route in
                switch route {
                case .login:
                    LoginView()

                case .account:
                    AccountView()

                case .article(let article):
                    ArticleDetailView(
                        article: article,
                        isSaved: session.savedArticles.contains(article.id),  // <- CHECK
                        toggleSave: {
                            let categoryKey = "category_\(article.category.lowercased().replacingOccurrences(of: " ", with: "_"))"

                            if session.savedArticles.contains(article.id) {
                                session.savedArticles.remove(article.id)
                                print("Unsubscribed from category: \(article.category)")

                                // Remove or update tag
                                OneSignal.User.addTag(key: categoryKey, value: "")
                            } else {
                                session.savedArticles.insert(article.id)
                                print("Subscribed to category: \(article.category)")

                                // Send tag to OneSignal
                                OneSignal.User.addTag(key: categoryKey, value: "subscribed")
                            }
                        },
                        isLiked: session.likedArticles.contains(article.id),  // <- CHECK
                        toggleLike: {
                            if session.likedArticles.contains(article.id) {
                                session.likedArticles.remove(article.id)
                            } else {
                                session.likedArticles.insert(article.id)

                                OneSignal.Session.addOutcome("Like")
                                print("Liked \(article.title)")
                            }
                        }

                    )
                }
            }
            .onChange(of: session.shouldResetNavigation) { oldValue, newValue in
                if newValue {
                    path = []
                    session.shouldResetNavigation = false
                }
            }
            .onAppear{
                print("current user: ",session.currentUser)
            }
        }
    }
}
