//
//  UIPostsTests.swift
//  miniPostUITests
//
//  Created by Víctor Barrios Sánchez on 8/5/24.
//

import XCTest

final class UIPostsTests: UIBaseTest {
    func testThatUserCanSwitchToProfileTab() {
        _ = start()
            .checkThatTheThreeTabsAppear()
            .checkThatPostsAppear()
            .tapOnProfile()
            .checkThatProfileLoads()
            .tapOnPosts()
            .checkThatPostsAppear()
    }
}
