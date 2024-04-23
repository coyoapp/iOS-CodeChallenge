//
//  UserServiceSuccess.swift
//  miniPostTests
//
//  Created by Triet Le on 23.4.2024.
//

import XCTest
@testable import miniPost

struct UserServiceSuccess: UserServiceProtocol {
    static let mock: Users = [
        User(
            id: 1,
            name: "John Doe",
            username: "username",
            email: "email",
            address: .init(
                street: "street",
                suite: "suite",
                city: "city",
                zipcode: "zipcode"
            ),
            phone: "123-456",
            website: "test.local",
            company: .init(
                name: "name",
                catchPhrase: "catchPhrase",
                bs: "bs"
            )
        )
    ]

    func fetchAllUsers() async throws -> miniPost.Users {
        return Self.mock
    }

    func fetchUserDetails(_ userId: String) async throws -> miniPost.User {
        return Self.mock[0]
    }
}
