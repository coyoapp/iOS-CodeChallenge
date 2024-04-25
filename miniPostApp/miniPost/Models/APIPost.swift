//
//  APIPost.swift
//  miniPost
//
//  Created by Amine Hajri on 25.04.24.
//

import Foundation

struct APIPost: Codable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
}
