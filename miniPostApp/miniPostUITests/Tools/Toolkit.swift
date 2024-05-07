//
//  Toolkit.swift
//  miniPostUITests
//
//  Created by Víctor Barrios Sánchez on 7/5/24.
//

import Foundation
import XCTest

func assertElementExists(_ element: XCUIElement, until waitingTime: Int = 5) {
    let exists = element.waitForExistence(timeout: TimeInterval(waitingTime))
    XCTAssertTrue(exists)
}
