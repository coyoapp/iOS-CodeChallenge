//
//  UserTests.swift
//  miniPostTests
//
//  Created by Amine Hajri on 25.04.24.
//

import XCTest
@testable import miniPost

final class UserTests: XCTestCase {
    let user = User(id: 0, name: "John Doe", phone: "123-456", website: "test.local")
    
    func testUserHash() throws {
        let hash = user.getUserHash()
        XCTAssertEqual(hash, "JoDo579test")
    }
}
