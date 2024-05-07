//
//  APIManager.swift
//  miniPost
//
//  Created by Robert Lang on 21/3/24.
//

import Foundation

private let apiUrl = "https://jsonplaceholder.typicode.com/"
private let session = URLSession.shared

// TODO: Remove when unused

private func performUsersListAPICall(endpointUrl: String) async throws -> [UserDTO] {
    let (data, _) = try await URLSession.shared.data(from: URL(string: apiUrl + "/users")!)
    let userList = try JSONDecoder().decode([UserDTO].self, from: data)
    return userList
}

@available(*, deprecated, message: "Use UsersDataSource instead")
func getUsers() async -> [UserDTO] {
    do {
        return try await performUsersListAPICall(endpointUrl: "users")
    } catch {
        return []
    }
}
