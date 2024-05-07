//
//  UsersPresenter.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 7/5/24.
//

import Foundation

protocol UsersPresenter {
    var users: [User] { get }
    func viewDidLoad() async
}

class UsersPresenterImplementation: UsersPresenter {
    weak var view: UIUsersListView?
    var users: [User] = []
    
    private let getAllUsersUseCase: GetAllUsersUseCase
    
    init(getAllUsersUseCase: GetAllUsersUseCase) {
        self.getAllUsersUseCase = getAllUsersUseCase
    }
    
    func viewDidLoad() async {
        users = await getAllUsersUseCase()
        
        await MainActor.run {
            view?.didLoadData()
        }
    }
}
