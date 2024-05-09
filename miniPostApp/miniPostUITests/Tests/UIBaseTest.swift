//
//  UIBaseTest.swift
//  miniPostUITests
//
//  Created by Víctor Barrios Sánchez on 7/5/24.
//

import XCTest

class UIBaseTest: XCTestCase {
    var app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
    }
    
    func start() -> PostsPage {
        app.launch()
        return PostsPage(app: app)
    }
}
