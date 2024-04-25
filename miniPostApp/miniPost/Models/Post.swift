//
//  Post.swift
//  miniPost
//
//  Created by Robert Lang on 22/3/24.
//

import Foundation

struct Post: Codable, Equatable {
    let id: Int
    var authorName: String
    let title: String
    let body: String
}
