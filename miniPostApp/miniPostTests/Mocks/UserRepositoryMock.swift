//
//  UserRepositoryMock.swift
//  miniPostTests
//
//  Created by Amine Hajri on 25.04.24.
//

import Foundation
import Combine
@testable import miniPost

final class UserRepositoryMock: UserRepositoryProtocol {
    func getUsers() -> AnyPublisher<[User], any Error> {
        Just(MockedDataSource.users)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func getUser(id: String) -> AnyPublisher<User, any Error> {
        Just(MockedDataSource.users.first(where: {String($0.id) == id}) ?? MockedDataSource.users[0])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
