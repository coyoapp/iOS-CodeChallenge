//
//  UserServiceFail.swift
//  miniPostTests
//
//  Created by Triet Le on 23.4.2024.
//

import XCTest
@testable import miniPost

struct UserServiceFail: UserServiceProtocol {
    func fetchAllUsers() async throws -> miniPost.Users {
        throw APIError.malformedURLRequest
    }
    
    func fetchUserDetails(_ userId: String) async throws -> miniPost.User {
        throw APIError.malformedURLRequest
    }
}
