//
//  PostRowView.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 8/5/24.
//

import SwiftUI

struct PostRowView: View {
    private let cardCornerRadius: CGFloat = 10
    private let shadowColor = Color.gray.opacity(0.6)
    
    let post: PostDisplay
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(post.title.capitalizedSentence)
                    .font(.headline)
                
                Text("by " + post.authorName)
                    .font(.footnote)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.gray.opacity(0.4))
            
            Text(post.body.capitalizedSentence)
                .font(.callout)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
                .padding(.bottom)
        }
        .fontDesign(.serif)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: cardCornerRadius))
        .overlay(
            RoundedRectangle(cornerRadius: cardCornerRadius)
                .stroke(.gray, lineWidth: 1)
        )
        .shadow(color: shadowColor, radius: 4, x: 4, y: 6)
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("post")
    }
}

#if DEBUG
#Preview {
    PostRowView(post: .init(id: 0, authorName: "John Doe", title: "The Beginning", body: "once upon a time..."))
}
#endif

private extension String {
    var capitalizedSentence: String {
        let firstLetter = self.prefix(1).capitalized
        let remainingLetters = self.dropFirst()
        return firstLetter + remainingLetters
    }
}
