//
//  PostViewModel.swift
//  miniPost
//
//  Created by Dmitry Suvorov on 29.4.2024.
//

import Foundation

final class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    private let postService: PostService
    private let userService: UserService

    init(postService: PostService, userService: UserService) {
        self.postService = postService
        self.userService = userService
    }

    func onAppear() {
        fetchPosts()
    }
}

// MARK: - Private
private extension PostViewModel {
    func fetchPosts() {
        Task(priority: .utility) { [weak self] in
            guard let self else { return }
            do {
                let remotePosts = try await postService.fetchPostList()
                let userIds = Array(Set(remotePosts.map { $0.userId }))
                let users = try await fetchUserList(userIds)

                let posts = try remotePosts.map { remote in
                    guard
                        let userName = users.first(where: { $0.id == remote.userId })?.name
                    else {
                        throw NSError(domain: "Fetch users", code: 99, userInfo: ["description": "Can't find user with id: \(remote.userId)"])
                    }
                    return Translator.postFromRemote(
                        remote,
                        authorName: userName
                    )
                }
                DispatchQueue.main.async {
                    self.posts = posts
                }
            } catch {
                print("Error fetching posts or user details: \(error)")
            }
        }
    }

    func fetchUserList(_ userIds: [Int]) async throws -> [UserRemote] {
        var userDetails: [UserRemote] = []
        try await withThrowingTaskGroup(
            of: UserRemote.self,
            body: { group in
                for userId in userIds {
                    group.addTask {
                        try await self.userService.fetchUserDetail(id: userId)
                    }
                }

                for try await userDetail in group {
                    userDetails.append(userDetail)
                }
            }
        )
        return userDetails
    }
}
