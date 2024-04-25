//
//  UserAPIHandlerProtocol.swift
//  miniPost
//
//  Created by Amine Hajri on 25.04.24.
//

import Foundation
import Combine

protocol UserAPIHandlerProtocol {
    func performUsersListAPICall() -> AnyPublisher<[User], Error>
    func performUserDetailAPICall(id: String) -> AnyPublisher<User, Error>
}
