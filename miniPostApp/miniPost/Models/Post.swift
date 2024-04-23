//
//  Post.swift
//  miniPost
//
//  Created by Robert Lang on 22/3/24.
//

import Foundation

// MARK: - Post
struct Post: Codable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}

typealias Posts = [Post]
