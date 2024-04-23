//
//  UsersViewModel.swift
//  miniPost
//
//  Created by Triet Le on 23.4.2024.
//

import Foundation

@MainActor
final class UsersViewModel: ObservableObject {
    // MARK: - Observables
    @Published var users: Users = []
    @Published var isLoading = true
    @Published var showError = false

    // MARK: - Private properties
    private let userService: UserServiceProtocol

    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }

    // MARK: - Public methods
    func onAppear() {
        Task {
            await fetchUsers()
        }
    }

    func retry() {
        Task {
            await fetchUsers()
        }
    }

    // MARK: - Private methods
    private func fetchUsers() async {
        do {
            let users = try await userService.fetchAllUsers()
            self.users = users
            isLoading = false
        } catch {
            isLoading = false
            // TODO: - Parse and display better errors
            print(error.localizedDescription)
            showError = true
        }
    }
}
