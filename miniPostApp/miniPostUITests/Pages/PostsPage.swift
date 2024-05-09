//
//  PostsPage.swift
//  miniPostUITests
//
//  Created by Víctor Barrios Sánchez on 7/5/24.
//

import Foundation
import XCTest

final class PostsPage: BasePage, TabBarComponent {
    private enum Posts: String {
        case post
        
        var element: XCUIElement {
            switch self {
            case .post:
                XCUIApplication().otherElements[rawValue]
            }
        }
    }
    
    func checkThatPostsAppear() -> Self {
        assertElementExists(Posts.post.element)
        return self
    }
}
