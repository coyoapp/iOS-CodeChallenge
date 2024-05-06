//
//  APIManager.swift
//  miniPost
//
//  Created by Robert Lang on 21/3/24.
//

import Foundation

// TODO: Remove this file and create a proper NetworkClient
// Resolve all forced unwrap cases, and handle errors properly

private let apiUrl = "https://jsonplaceholder.typicode.com/"
private let session = URLSession.shared



func performUsersListAPICall(endpointUrl: String) async throws -> [UserDTO] {
    let (data, _) = try await URLSession.shared.data(from: URL(string: apiUrl + "/users")!)
    let userList = try JSONDecoder().decode([UserDTO].self, from: data)
    return userList
}

func performUserDetailAPICall(endpointUrl: String, id: String) async throws -> UserDTO {
    let (data, _) = try await URLSession.shared.data(from: URL(string: apiUrl + "/users/" + id)!)
    let userList = try JSONDecoder().decode(UserDTO.self, from: data)
    return userList
}

// TODO: Check what to return if the request fails
func getUsers() async -> [UserDTO] {
    do {
        return try await performUsersListAPICall(endpointUrl: "users")
    } catch {
        return []
    }
}

func getUser(id: String) async -> UserDTO {
    return try! await performUserDetailAPICall(endpointUrl: "user/", id: id)
}

