//
//  APIManager.swift
//  miniPost
//
//  Created by Robert Lang on 21/3/24.
//

import Foundation

enum Const {
    static let apiUrl = "https://jsonplaceholder.typicode.com"
    static let session = URLSession.shared
}

struct User: Codable {
    let id: Int
    let name: String
    let phone: String
    let website: String
}

func performUsersListAPICall(endpointUrl: String) async throws -> [User] {
    let (data, _) = try await URLSession.shared.data(from: URL(string: Const.apiUrl + "/users")!)
    let userList = try JSONDecoder().decode([User].self, from: data)
    return userList
}

func performUserDetailAPICall(endpointUrl: String, id: String) async throws -> User {
    let (data, _) = try await URLSession.shared.data(from: URL(string: Const.apiUrl + "/users/" + id)!)
    let userList = try JSONDecoder().decode(User.self, from: data)
    return userList
}

func getUsers(callback: @escaping ([User]) -> Void) {
    Task(priority: .utility) {
        let result = try await performUsersListAPICall(endpointUrl: "/users")
        callback(result)
    }
}

func getUser(id: String) async -> User {
    return try! await performUserDetailAPICall(endpointUrl: "/user/", id: id)
}

