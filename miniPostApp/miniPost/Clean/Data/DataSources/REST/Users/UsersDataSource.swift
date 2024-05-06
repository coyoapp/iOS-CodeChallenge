//
//  UsersDataSource.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 6/5/24.
//

import Foundation

protocol UsersDataSource {
    func getUser(id: String) async throws -> UserDTO
    func getUsers() async throws -> [UserDTO]
}

struct UsersDataSourceImplementation: UsersDataSource {
    private let apiClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.apiClient = networkClient
    }
    
    func getUser(id: String) async throws -> UserDTO {
        try await apiClient.perform(request: UserRequest(id: id))
    }
    
    func getUsers() async throws -> [UserDTO] {
        try await apiClient.perform(request: UsersRequest())
    }
}
