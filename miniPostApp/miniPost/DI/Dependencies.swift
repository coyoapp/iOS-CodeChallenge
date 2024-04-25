//
//  Dependencies.swift
//  miniPost
//
//  Created by Amine Hajri on 25.04.24.
//

import Foundation

final class Dependencies {
    init() {
        @Provider var userAPI = UserAPIHandler() as UserAPIHandlerProtocol
        @Provider var postAPI = PostAPIHandler() as PostAPIHandlerProtocol
        
        @Provider var userRepository = UserRepository(userAPI: userAPI) as UserRepositoryProtocol
        @Provider var postRepository = PostRepository(postAPI: postAPI) as PostRepositoryProtocol
    }
}
