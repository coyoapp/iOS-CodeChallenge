//
//  PostsView.swift
//  miniPost
//
//  Created by Robert Lang on 22/3/24.
//

import SwiftUI

struct PostsView: View {
    @State var viewModel: PostsViewModel
    
    var body: some View {
        VStack {
            if viewModel.posts.isEmpty {
                Text("Loading posts...")
                    .accessibilityIdentifier("loading")
            } else {
                List(viewModel.posts, id: \.id) { post in
                    PostsListRow(post: post)
                }
            }
        }
        .task {
            await viewModel.onAppear()
        }
    }
}

struct PostsListRow: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(post.title)
                .font(.headline)
            Text("By "+post.authorName)
                .font(.subheadline)
            Text(post.body)
                .font(.body)
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("post")
    }
}

#if DEBUG
#Preview {
    PostsView(
        viewModel: .init(getAllPostsUseCase: GetAllPostsUseCasePreviewMock())
    )
}
#endif
