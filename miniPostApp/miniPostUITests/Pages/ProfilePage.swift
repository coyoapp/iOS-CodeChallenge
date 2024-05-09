//
//  ProfilePage.swift
//  miniPostUITests
//
//  Created by Víctor Barrios Sánchez on 10/5/24.
//

import Foundation
import XCTest

final class ProfilePage: BasePage, TabBarComponent {
    private enum Profile: String {
        case phone
        case website
        case userHash
        case profilePicture
        
        var element: XCUIElement {
            switch self {
            case .phone, .website, .userHash:
                XCUIApplication().otherElements[rawValue]
                
            case .profilePicture:
                XCUIApplication().images[rawValue]
            }
        }
    }
    
    func checkThatProfileLoads() -> Self {
        assertElementExists(Profile.phone.element)
        assertElementExists(Profile.website.element)
        assertElementExists(Profile.userHash.element)
        assertElementExists(Profile.profilePicture.element)
        return self
    }
}
