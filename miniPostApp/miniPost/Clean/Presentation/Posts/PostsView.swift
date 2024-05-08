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
        ScrollView {
            LazyVStack(spacing: 20) {
                if case let .loaded(posts) = viewModel.state {
                    ForEach(posts) { post in
                        PostRowView(post: post)
                            .scrollTransition { effect, phase in
                                effect
                                    .scaleEffect(phase.isIdentity ? 1 : 0.85)
                            }
                    }
                }
            }
            .padding()
        }
        .loadingState(viewModel.state)
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
