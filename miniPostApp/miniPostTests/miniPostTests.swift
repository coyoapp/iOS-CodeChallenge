//
//  miniPostTests.swift
//  miniPostTests
//
//  Created by Robert Lang on 21/3/24.
//

import XCTest
@testable import miniPost

final class miniPostTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testUserHash() throws {
        let hash = calculateUserHash(name: "John Doe", phone: "123-456", website: "test.local")
        XCTAssertEqual(hash, "JoDo579test")
    }

}
