//
//  MiniPostApp.swift
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
struct MiniPostApp: App {
    var body: some Scene {
        WindowGroup {
            // TODO: Review this initialisation point.
            // It migth be a good idea to create an AppDelegate if we need this data loaded beforehand.
            
            if AppModules.modules.modulesLoaded {
                MainMenuView()
            } else {
                Text("Loading...")
            }
        }
    }
}
