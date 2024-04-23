//
//  PostServiceFail.swift
//  miniPostTests
//
//  Created by Triet Le on 23.4.2024.
//

import XCTest
@testable import miniPost

struct PostServiceFail: PostServiceProtocol {
    func fetchAllPosts() async throws -> miniPost.Posts {
        throw APIError.malformedURLRequest
    }
}
