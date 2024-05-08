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
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(viewModel.posts) { post in
                            PostRowView(post: post)
                                .scrollTransition { effect, phase in
                                    effect
                                        .scaleEffect(phase.isIdentity ? 1 : 0.85)
                                }
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Posts")
        .task {
            await viewModel.onAppear()
        }
    }
}

#if DEBUG
#Preview {
    PostsView(
        viewModel: .init(getAllPostsUseCase: GetAllPostsUseCasePreviewMock())
    )
}
#endif
