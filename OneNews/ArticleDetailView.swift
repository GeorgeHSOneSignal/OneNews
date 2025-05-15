import SwiftUI
import OneSignalFramework

struct ArticleDetailView: View {
    @EnvironmentObject var session: UserSession
    @State private var isSubscribed: Bool = false
    let article: Article
    let isSaved: Bool
    let toggleSave: () -> Void
    let isLiked: Bool
    let toggleLike: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let imageName = article.imageName {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(12)
                }

                Text(article.title)
                    .font(.title)
                    .bold()
                Text(article.subtitle)
                    .font(.subheadline)
                    .bold()
                Text(article.date)
                    .font(.subheadline)
                    .foregroundColor(.blue)
                
                HStack {
                    Button(action: {
                        isSubscribed.toggle()
                        
                        if isSubscribed {
                            OneSignal.User.addTag(key: "category_\(article.category)", value: "subscribed")
                            session.subscribedCategories.insert(article.category)
                            print("Subscribed to category: \(article.category)")
                        } else {
                            OneSignal.User.removeTag("category_\(article.category)")
                            session.subscribedCategories.remove(article.category)
                            print("Unsubscribed from category: \(article.category)")
                        }
                    }) {
                        HStack {
                            Image(systemName: isSubscribed ? "checkmark.circle.fill" : "plus.circle.fill")
                                .foregroundColor(isSubscribed ? .blue : .green)
                            Text(article.category.capitalized)
                        }
                    }

                    Spacer()

                    Button(action: toggleLike) {
                        Image(systemName: isLiked ? "hand.thumbsup.fill" : "hand.thumbsup")
                            .foregroundColor(isLiked ? .blue : .gray)
                            .padding(8)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }
                    .buttonStyle(PlainButtonStyle())
                }


                Text(article.body)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .onAppear {
            let lowercasedCategory = article.category.lowercased()
            isSubscribed = session.subscribedCategories.contains { $0.lowercased() == lowercasedCategory }
            print(session.subscribedCategories.contains { $0.lowercased() == lowercasedCategory })
            print(session.subscribedCategories)
            print(article.category)
        }
        .navigationTitle("Article")
        .navigationBarTitleDisplayMode(.inline)
    }
}

