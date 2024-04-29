//
//  PostsView.swift
//  miniPost
//
//  Created by Robert Lang on 22/3/24.
//

import SwiftUI

struct PostView: View {
    @ObservedObject var viewModel: PostViewModel

    var body: some View {
        VStack {
            if viewModel.posts.isEmpty {
                Text("Loading posts...")
            } else {
                List(viewModel.posts, id: \.id) { post in
                    VStack(alignment: .leading) {
                        Text(post.title)
                            .font(.headline)
                        Text("By " + post.authorName)
                            .font(.subheadline)
                        Text(post.body)
                            .font(.body)
                    }
                }
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

#Preview {
    PostView(
        viewModel: PostViewModel(
            postService: PostServiceImpl(),
            userService: UserServiceImpl()
        )
    )
}
