//
//  PostService.swift
//  miniPost
//
//  Created by Triet Le on 23.4.2024.
//

import Foundation

/// This is dedicated for all use related API
/// Can be extended in future for more calls
protocol PostServiceProtocol {
    func fetchAllPosts() async throws -> Posts
}

struct PostService: PostServiceProtocol {
    func fetchAllPosts() async throws -> Posts {
        try await PostsRequest().execute()
    }
}
