//
//  miniPostApp.swift
//  miniPost
//
//  Created by Robert Lang on 21/3/24.
//

import SwiftUI

class AppModules {
    static let modules = AppModules()

    public var profileModule: ProfilePresenter?
    public var modulesLoaded: Bool = false

     init() {
         profileModule = createProfileModule()
         modulesLoaded = true
    }
}

@main
struct miniPostApp: App {
    var body: some Scene {
        WindowGroup {
            if AppModules.modules.modulesLoaded {
                MainMenuView()
            } else {
                Text("Loading...")
            }
        }
    }
}
