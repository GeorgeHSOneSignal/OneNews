//
//  ArticleRow.swift
//  OneNews
//
//  Created by George Hitchman-Smith on 14/05/2025.
//


// File: ArticleRow.swift

import SwiftUI

struct ArticleRow: View {
    let article: Article

    var body: some View {
        HStack(alignment: .top) {
            if let imageName = article.imageName {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipped()
                    .cornerRadius(8)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(article.title)
                    .font(.headline)
                Text(article.subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                Text(article.date)
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .lineLimit(3)
            }
        }
        .padding(.vertical, 8)
    }
}
