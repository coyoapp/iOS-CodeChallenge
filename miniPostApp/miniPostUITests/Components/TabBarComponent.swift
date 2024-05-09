//
//  TabBarComponent.swift
//  miniPostUITests
//
//  Created by Víctor Barrios Sánchez on 10/5/24.
//

import Foundation
import XCTest

private enum TabBar: String {
    case postsItem = "Posts"
    case usersItem = "Users"
    case profileItem = "Profile"
    
    var element: XCUIElement {
        switch self {
        case .postsItem, .usersItem, .profileItem:
            XCUIApplication().buttons[rawValue]
        }
    }
}

protocol TabBarComponent {
    var app: XCUIApplication { get set }
}

extension TabBarComponent {
    func checkThatTheThreeTabsAppear() -> Self {
        assertElementExists(TabBar.postsItem.element)
        assertElementExists(TabBar.usersItem.element)
        assertElementExists(TabBar.profileItem.element)
        
        return self
    }
    
    func tapOnPosts() -> PostsPage {
        TabBar.postsItem.element.tap()
        return PostsPage(app: app)
    }
    
    // TODO: We could add `Users` here
    
    func tapOnProfile() -> ProfilePage {
        TabBar.profileItem.element.tap()
        return ProfilePage(app: app)
    }
}
