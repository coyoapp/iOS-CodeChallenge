//
//  miniPostApp.swift
//  miniPost
//
//  Created by Robert Lang on 21/3/24.
//

import SwiftUI

@main
struct miniPostApp: App {
    private let appServices = AppServices(
        postService: PostServiceImpl(),
        userService: UserServiceImpl()
    )

    var body: some Scene {
        WindowGroup {
            MainMenuView(viewModel: MainMenuViewModel(appServices: appServices))
         }
    }
}
