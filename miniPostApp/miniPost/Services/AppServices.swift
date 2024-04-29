//
//  AppServices.swift
//  miniPost
//
//  Created by Dmitry Suvorov on 29.4.2024.
//

import Foundation

final class AppServices {
    var postService: PostService
    var userService: UserService

    init(postService: PostService, userService: UserService) {
        self.postService = postService
        self.userService = userService
    }
}
