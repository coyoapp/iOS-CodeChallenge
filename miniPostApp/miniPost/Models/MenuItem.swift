//
//  MenuItem.swift
//  miniPost
//
//  Created by Triet Le on 23.4.2024.
//

import SwiftUI

enum MenuItem: String, CaseIterable {
    case posts
    case users
    case profile
}

extension MenuItem {
    // TODO: - Localization
    var title: String {
        switch self {
        case .posts:
            return "Posts"
        case .users:
            return "Users"
        case .profile:
            return "Profile"
        }
    }

    var icon: String {
        switch self {
        case .posts:
            return "message"
        case .users:
            return "person.3"
        case .profile:
            return "person.text.rectangle"
        }
    }

    @ViewBuilder
    var destination: some View {
        switch self {
        case .posts:
            PostsView()
        case .users:
            UsersView()
        case .profile:
            ProfileView(viewModel: .init(user: nil))
        }
    }
}
