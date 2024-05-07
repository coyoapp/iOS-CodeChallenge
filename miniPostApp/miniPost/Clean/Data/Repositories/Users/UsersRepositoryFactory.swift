//
//  UsersRepositoryFactory.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 7/5/24.
//

import Foundation

enum UsersRepositoryFactory {
    static func make() -> UsersRepository {
        let dataSource = UsersDataSourceImplementation(networkClient: ApiClient())
        return UsersRepositoryImplementation(usersDataSource: dataSource)
    }
}
