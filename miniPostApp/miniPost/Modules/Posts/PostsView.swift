//
//  PostsView.swift
//  miniPost
//
//  Created by Robert Lang on 22/3/24.
//

import SwiftUI

struct PostsView: View {
    @ObservedObject private var postViewModel = PostsViewModel()
    
    var body: some View {
        VStack {
            if postViewModel.posts.isEmpty {
                Text("Loading posts...")
            } else {
                List(postViewModel.posts, id: \.id) { post in
                    VStack(alignment: .leading) {
                        Text(post.title)
                            .font(.headline)
                        Text("By "+post.authorName)
                            .font(.subheadline)
                        Text(post.body)
                            .font(.body)
                    }
                }
            }
        }
        .onAppear(perform: postViewModel.getPosts)
    }
}
