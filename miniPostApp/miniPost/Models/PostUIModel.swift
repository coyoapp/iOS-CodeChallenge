//
//  PostUIModel.swift
//  miniPost
//
//  Created by Triet Le on 23.4.2024.
//

import Foundation

struct PostUIModel: Identifiable {
    let id = UUID()
    let details: Post
    let author: String
}
