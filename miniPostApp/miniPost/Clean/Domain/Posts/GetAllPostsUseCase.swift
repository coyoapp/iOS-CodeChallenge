//
//  GetAllPostsUseCase.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 6/5/24.
//

import Foundation

protocol GetAllPostsUseCase {
    func callAsFunction() async -> [Post]
}

struct GetAllPostsUseCaseImplementation: GetAllPostsUseCase {
    private let postsRepository: PostsRepository
    
    init(postsRepository: PostsRepository) {
        self.postsRepository = postsRepository
    }
    
    func callAsFunction() async -> [Post] {
        do {
            return try await postsRepository.getAllPosts()
        } catch {
            return []
        }
    }
}

#if DEBUG
struct GetAllPostsUseCasePreviewMock: GetAllPostsUseCase {
    func callAsFunction() async -> [Post] {
        [
            .init(id: 0, authorName: "John Doe", title: "The Beginning", body: "Once upon a time...")
        ]
    }
}
#endif
