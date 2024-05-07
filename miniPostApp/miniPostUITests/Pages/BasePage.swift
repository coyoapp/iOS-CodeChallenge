//
//  BasePage.swift
//  miniPostUITests
//
//  Created by Víctor Barrios Sánchez on 7/5/24.
//

import Foundation
import XCTest

class BasePage {
    var app: XCUIApplication
    
    required init(app: XCUIApplication) {
        self.app = app
    }
}
