//
//  MiniPostApp.swift
//  miniPost
//
//  Created by Robert Lang on 21/3/24.
//

import SwiftUI

@main
struct MiniPostApp: App {
    let dependencies = Dependencies()
    
    var body: some Scene {
        WindowGroup {
            MainMenuView()
        }
    }
}
