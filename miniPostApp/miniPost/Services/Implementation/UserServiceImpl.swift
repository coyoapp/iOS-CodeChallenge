//
//  UserServiceImpl.swift
//  miniPost
//
//  Created by Dmitry Suvorov on 28.4.2024.
//

import Foundation

final class UserServiceImpl: UserService {
    private let session = URLSession.shared
    private let jsonDecoder = JSONDecoder()

    func fetchUserList() async throws -> [UserRemote] {
        let url = Const.apiUrl.appendingPathComponent("users")
        let (data, _) = try await session.data(from: url)
        return try jsonDecoder.decode([UserRemote].self, from: data)
    }

    func fetchUserDetail(id: Int) async throws -> UserRemote {
        let url = Const.apiUrl.appendingPathComponent("users").appendingPathComponent("\(id)")
        let (data, _) = try await session.data(from: url)
        return try jsonDecoder.decode(UserRemote.self, from: data)
    }
}
