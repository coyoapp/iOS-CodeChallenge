//
//  MainMenuViewModel.swift
//  miniPost
//
//  Created by Dmitry Suvorov on 29.4.2024.
//

import SwiftUI

final class MainMenuViewModel: ObservableObject {
    struct MainMenuItem: Identifiable {
        let id = UUID()
        let name: String
        let image: String
    }

    private let appServices: AppServices
    @Published var items: [MainMenuItem] = []

    init(appServices: AppServices) {
        self.appServices = appServices
        setUpMenuItems()
    }

    @ViewBuilder
    func destinationView(for item: MainMenuItem) -> some View {
        switch item.name {
        case "Posts":
            PostView(
                viewModel: PostViewModel(
                    postService: appServices.postService,
                    userService: appServices.userService
                )
            )
        case "Users":
            UserListView(
                viewModel: UserListViewModel(
                    userService: appServices.userService
                )
            )
        case "Profile":
            ProfileView(viewModel: ProfileViewModel(userService: appServices.userService))
        default:
            EmptyView()
        }
    }
}

// MARK: - Private
private extension MainMenuViewModel {
    func setUpMenuItems() {
        items = [
            MainMenuItem(name: "Posts", image: "message"),
            MainMenuItem(name: "Users", image: "person.3"),
            MainMenuItem(name: "Profile", image: "person.text.rectangle")
        ]
    }
}
