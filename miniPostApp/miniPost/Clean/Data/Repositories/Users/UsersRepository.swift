//
//  UsersRepository.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 7/5/24.
//

import Foundation

protocol UsersRepository {
    func getProfile(for userId: String) async throws -> User
    func getUsers() async throws -> [User]
}

struct UsersRepositoryImplementation: UsersRepository {
    private let usersDataSource: UsersDataSource
    
    init(usersDataSource: UsersDataSource) {
        self.usersDataSource = usersDataSource
    }
    
    func getProfile(for userId: String) async throws -> User {
        let userDTO = try await usersDataSource.getUser(id: userId)
        return userDTO.toDomain
    }
    
    func getUsers() async throws -> [User] {
        try await usersDataSource.getUsers().map { $0.toDomain }
    }
}
