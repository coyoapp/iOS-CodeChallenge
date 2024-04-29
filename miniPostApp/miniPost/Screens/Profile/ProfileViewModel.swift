//
//  ProfileViewModel.swift
//  miniPost
//
//  Created by Dmitry Suvorov on 29.4.2024.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    @Published var user: User?
    private var userService: UserService?

    init(userService: UserService) {
        self.userService = userService
    }

    init(user: User) {
        self.user = user
    }

    func onAppear() {
        guard userService != nil else { return }
        fetchUser()
    }
}

// MARK: - Private
private extension ProfileViewModel {
    func fetchUser() {
        Task(priority: .utility) { [weak self] in
            do {
                guard let self, let userService else { return }
                let remote = try await userService.fetchUserDetail(id: Const.ownUserId)
                DispatchQueue.main.async {
                    self.user = Translator.userFromRemote(remote)
                }
            } catch {
                print("Error fetching user details: \(error)")
            }
        }
    }
}
