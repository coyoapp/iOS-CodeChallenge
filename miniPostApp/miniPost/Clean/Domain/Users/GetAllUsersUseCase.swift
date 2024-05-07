//
//  GetAllUsersUseCase.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 7/5/24.
//

import Foundation

protocol GetAllUsersUseCase {
    func callAsFunction() async -> [User]
}

struct GetAllUsersUseCaseImplementation: GetAllUsersUseCase {
    private let usersRepository: UsersRepository
    
    init(usersRepository: UsersRepository) {
        self.usersRepository = usersRepository
    }
    
    func callAsFunction() async -> [User] {
        do {
            return try await usersRepository.getUsers()
        } catch {
            return []
        }
    }
}
