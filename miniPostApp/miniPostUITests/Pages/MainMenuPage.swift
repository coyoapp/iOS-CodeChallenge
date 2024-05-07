//
//  MainMenuPage.swift
//  miniPostUITests
//
//  Created by Víctor Barrios Sánchez on 7/5/24.
//

import Foundation
import XCTest

final class MainMenuPage: BasePage {
    private enum MainMenu: String {
        case postsItem = "Posts"
        case usersItem = "Users"
        case profileItem = "Profile"
        
        var element: XCUIElement {
            switch self {
            case .postsItem, .usersItem, .profileItem:
                XCUIApplication().staticTexts[rawValue]
            }
        }
    }
    
    func checkThatTheThreeSectionsAppear() -> Self {
        assertElementExists(MainMenu.postsItem.element)
        assertElementExists(MainMenu.usersItem.element)
        assertElementExists(MainMenu.profileItem.element)
        
        return self
    }
    
    func tapOnPosts() -> PostsPage {
        MainMenu.postsItem.element.tap()
        return PostsPage(app: app)
    }
}
