//
//  UserRepositoryProtocol.swift
//  miniPost
//
//  Created by Amine Hajri on 25.04.24.
//

import Foundation
import Combine

protocol UserRepositoryProtocol {
    func getUsers() -> AnyPublisher<[User], Error>
    func getUser(id: String) -> AnyPublisher<User, Error>
}
