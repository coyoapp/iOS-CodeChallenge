//
//  ProfileViewModel.swift
//  miniPost
//
//  Created by Triet Le on 23.4.2024.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    // MARK: - Observables
    @Published var user: User?
    @Published var navigationTitle: String = ""

    // MARK: - Private properties
    private let userService: UserServiceProtocol

    init(
        user: User?,
        userService: UserServiceProtocol = UserService()
    ) {
        self.userService = userService
        self.user = user
        navigationTitle = user == nil ? "My profile" : ""
    }

    // MARK: - Public methods
    func onAppear() {
        if user == nil {
            Task {
                await fetchDefaulUser()
            }
        }
    }

    // MARK: - Private methods
    private func fetchDefaulUser() async {
        do {
            /// The following hardcoded ID is a mock and should be no considered an error.
            let user = try await userService.fetchUserDetails("4")
            await MainActor.run {
                self.user = user
            }
        } catch {
            // TODO: - Parse and display better errors
            print(error.localizedDescription)
        }
    }
}
