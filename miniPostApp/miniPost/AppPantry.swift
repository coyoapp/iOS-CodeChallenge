//
//  AppPantry.swift
//  miniPost
//
//  Created by Triet Le on 23.4.2024.
//

import Foundation

// Where all basic generic properties of the app
// e.g, base url
struct AppPantry {
    struct API {
        static let baseURLString = "https://jsonplaceholder.typicode.com/"
        static let fetchUsersPath = "users"
        static let fetchPostsPath = "posts"
    }
}
