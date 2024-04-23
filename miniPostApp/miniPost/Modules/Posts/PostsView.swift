//
//  PostsView.swift
//  miniPost
//
//  Created by Robert Lang on 22/3/24.
//

import SwiftUI

struct PostsView: View {
    @StateObject private var viewModel = PostsViewModel()

    var body: some View {
        ZStack(alignment: .center) {
            if viewModel.isLoading {
                ProgressView()
            } else {
                List {
                    ForEach(viewModel.uiModels) { post in
                        postView(post)
                    }
                }
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .alert("Something went wrong", isPresented: $viewModel.showError) {
            Button("Retry", role: .cancel) {
                viewModel.retry()
            }
        }
        .navigationTitle("Posts")
    }

    @ViewBuilder
    private func postView(_ post: PostUIModel) -> some View {
        VStack(alignment: .leading,  spacing: 8) {
            Text(post.details.title)
                .font(.title)
                .fontWeight(.black)

            Text("by \(post.author)")
                .font(.title2)
                .fontWeight(.semibold)

            Text(post.details.body)
                .font(.body)
        }
    }
}

#Preview {
    PostsView()
}
