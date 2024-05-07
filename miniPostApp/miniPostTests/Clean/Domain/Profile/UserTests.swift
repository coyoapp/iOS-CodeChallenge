//
//  UserTests.swift
//  miniPostTests
//
//  Created by Víctor Barrios Sánchez on 7/5/24.
//
@testable import miniPost
import XCTest

final class UserTests: XCTestCase {
    func testThatUserHashIsBuiltAsExpected() {
        let user = User(id: 0, name: "John Doe", phone: "123-456", website: "test.local")
        
        let hash = user.calculateUserHash()
        
        XCTAssertEqual("JoDo579test", hash)
    }
}
