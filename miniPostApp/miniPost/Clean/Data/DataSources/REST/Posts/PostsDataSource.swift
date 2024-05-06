//
//  PostsDataSource.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 6/5/24.
//

import Foundation

protocol PostsDataSource {
    func getPosts() async throws -> [PostDTO]
}

struct PostsDataSourceImplementation: PostsDataSource {
    private let apiClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.apiClient = networkClient
    }
    
    func getPosts() async throws -> [PostDTO] {
        try await apiClient.perform(request: PostsRequest())
    }
}
