//
//  PostsRepositoryFactory.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 7/5/24.
//

import Foundation

enum PostsRepositoryFactory {
    static func make() -> PostsRepository {
        let apiClient = ApiClient()
        let postsDataSource = PostsDataSourceImplementation(networkClient: apiClient)
        let usersDataSource = UsersDataSourceImplementation(networkClient: apiClient)
        
        return PostsRepositoryImplementation(postsDataSource: postsDataSource, usersDataSource: usersDataSource)
    }
}
