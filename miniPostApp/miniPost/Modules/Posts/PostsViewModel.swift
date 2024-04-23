//
//  PostsViewModel.swift
//  miniPost
//
//  Created by Triet Le on 23.4.2024.
//

import Foundation

@MainActor
final class PostsViewModel: ObservableObject {
    // MARK: - Observables
    @Published var uiModels: [PostUIModel] = []
    @Published var isLoading = true
    @Published var showError = false

    // MARK: - Private properties
    private let postService: PostServiceProtocol
    private let userService: UserServiceProtocol

    init(
        postService: PostServiceProtocol = PostService(),
        userService: UserServiceProtocol = UserService()
    ) {
        self.postService = postService
        self.userService = userService
    }

    // MARK: - Public methods
    func onAppear() {
        Task {
            await fetchPostsAndAuthors()
        }
    }

    func retry() {
        Task {
            await fetchPostsAndAuthors()
        }
    }

    // MARK: - Private methods
    private func fetchPostsAndAuthors() async {
        do {
            let posts = try await postService.fetchAllPosts()
            let users = try await userService.fetchAllUsers()
            let result = posts.map { post -> PostUIModel in
                let author = users.first(where: { $0.id == post.userId })?.name ?? "Unknown"
                return PostUIModel(details: post, author: author)
            }
            uiModels = result
            isLoading = false
        } catch {
            isLoading = false
            // TODO: - Parse and display better errors
            print(error.localizedDescription)
            showError = true
        }
    }
}
