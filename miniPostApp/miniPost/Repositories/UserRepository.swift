//
//  UserRepository.swift
//  miniPost
//
//  Created by Amine Hajri on 25.04.24.
//

import Foundation
import Combine

final class UserRepository: UserRepositoryProtocol {
    private let userAPI: UserAPIHandlerProtocol
    
    init(userAPI: UserAPIHandlerProtocol) {
        self.userAPI = userAPI
    }
    
    func getUsers() -> AnyPublisher<[User], any Error> {
        userAPI.performUsersListAPICall()
    }
    
    func getUser(id: String) -> AnyPublisher<User, any Error> {
        userAPI.performUserDetailAPICall(id: id)
    }
}
