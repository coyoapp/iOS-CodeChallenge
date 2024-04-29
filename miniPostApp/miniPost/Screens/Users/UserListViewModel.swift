//
//  UserListViewModel.swift
//  miniPost
//
//  Created by Dmitry Suvorov on 29.4.2024.
//

import Foundation

final class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isDetailsShown = false
    @Published var shownUser: User?

    private let userService: UserService

    init(userService: UserService) {
        self.userService = userService
    }

    func tappedItem(_ user: User) {
        shownUser = user
        isDetailsShown = true
    }

    func onAppear() {
        fetchUsers()
    }
}

// MARK: - Private
private extension UserListViewModel {
    func fetchUsers() {
        Task(priority: .utility) { [weak self] in
            guard let self else { return }
            do {
                let remoteUsers = try await userService.fetchUserList()
                let users = remoteUsers.map { Translator.userFromRemote($0) }
                DispatchQueue.main.async {
                    self.users = users
                }
            } catch {
                print("Error fetching user details: \(error)")
            }
        }
    }
}
