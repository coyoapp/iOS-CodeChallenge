//
//  GetProfileInformationUseCase.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 7/5/24.
//

import Foundation

protocol GetProfileInformationUseCase {
    func callAsFunction(userId: String) async throws -> User
}

struct GetProfileInformationUseCaseImplementation: GetProfileInformationUseCase {
    private let usersRepository: UsersRepository
    
    init(usersRepository: UsersRepository) {
        self.usersRepository = usersRepository
    }
    
    func callAsFunction(userId: String) async throws -> User {
        try await usersRepository.getProfile(for: userId)
    }
}
