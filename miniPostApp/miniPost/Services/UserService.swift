//
//  UserService.swift
//  miniPost
//
//  Created by Triet Le on 23.4.2024.
//

import Foundation

/// This is dedicated for all use related API
/// Can be extended in future for more calls
protocol UserServiceProtocol {
    func fetchAllUsers() async throws -> Users
    func fetchUserDetails(_ userId: String) async throws -> User
}

struct UserService: UserServiceProtocol {
    func fetchAllUsers() async throws -> Users {
        try await UsersRequest().execute()
    }

    func fetchUserDetails(_ userId: String) async throws -> User {
        try await UserDetailsRequest(userId: userId).execute()
    }
}
