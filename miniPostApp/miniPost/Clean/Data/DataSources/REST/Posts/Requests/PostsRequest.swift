//
//  PostsRequest.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 6/5/24.
//

import Foundation

struct PostsRequest: NetworkRequest {
    var path: String = "/posts"
    var parameters: [String : String] = [:]
}
