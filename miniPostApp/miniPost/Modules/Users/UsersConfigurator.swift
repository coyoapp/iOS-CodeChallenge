//
//  UsersConfigurator.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 7/5/24.
//

import Foundation

class UsersConfigurator {
    func configure(viewController: UsersListViewController) {
        let usersRepository = UsersRepositoryFactory.make()
        let getAllUsersUseCase = GetAllUsersUseCaseImplementation(usersRepository: usersRepository)
        let presenter = UsersPresenterImplementation(getAllUsersUseCase: getAllUsersUseCase)
        presenter.view = viewController
        
        viewController.presenter = presenter
    }
}
