//
//  ProfileViewFactory.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 7/5/24.
//

import Foundation

enum ProfileViewFactory {
    static func make() -> ProfileView {
        let usersRepository = UsersRepositoryFactory.make()
        let getProfileUseCase = GetProfileInformationUseCaseImplementation(usersRepository: usersRepository)
        let viewModel = ProfileViewModel(getProfileUseCase: getProfileUseCase)
        
        return ProfileView(viewModel: viewModel)
    }
}
