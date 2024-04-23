//
//  PostServiceSuccess.swift
//  miniPostTests
//
//  Created by Triet Le on 23.4.2024.
//

import XCTest
@testable import miniPost

struct PostServiceSuccess: PostServiceProtocol {
    static let mock: Posts = [
        .init(
            id: 1,
            userId: 1,
            title: "title",
            body: "body"
        )
    ]
    
    func fetchAllPosts() async throws -> miniPost.Posts {
        return Self.mock
    }
}
