//
//  APIUrls.swift
//  miniPost
//
//  Created by Amine Hajri on 25.04.24.
//

import Foundation

struct APIUrls {
    private static let baseUrl = "https://jsonplaceholder.typicode.com/"
    static let fetchUsersUrl = baseUrl + "/users"
    static let fetchUserByIdUrl = baseUrl + "/users/"
    static let fetchPostsUrl = baseUrl + "/posts"
}
