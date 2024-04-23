//
//  ProfileViewModelTests.swift
//  miniPostTests
//
//  Created by Triet Le on 23.4.2024.
//

import XCTest
@testable import miniPost

final class ProfileViewModelTests: XCTestCase {
    func testViewModelHasEmptyInit() {
        let viewModel = ProfileViewModel(user: nil, userService: UserServiceSuccess())
        XCTAssert(viewModel.user == nil)
        XCTAssert(viewModel.navigationTitle == "My profile")
    }

    func testViewModelHasUser() {
        let viewModel = ProfileViewModel(
            user: UserServiceSuccess.mock.first,
            userService: UserServiceSuccess()
        )
        XCTAssert(viewModel.user != nil)
        XCTAssert(viewModel.navigationTitle == "")
    }

    func testViewModelFetchUserFail() async {
        let viewModel = ProfileViewModel(user: nil, userService: UserServiceFail())
        XCTAssert(viewModel.user == nil)
        XCTAssert(viewModel.navigationTitle == "My profile")

        viewModel.onAppear()
        try? await Task.sleep(nanoseconds: UInt64(2 * 1_000_000_000))

        XCTAssert(viewModel.user == nil)
    }

    func testViewModelFetchUserSuccess() async {
        let viewModel = ProfileViewModel(user: nil, userService: UserServiceSuccess())
        XCTAssert(viewModel.user == nil)
        XCTAssert(viewModel.navigationTitle == "My profile")

        viewModel.onAppear()
        try? await Task.sleep(nanoseconds: UInt64(2 * 1_000_000_000))

        XCTAssert(viewModel.user == UserServiceSuccess.mock.first)
    }
}
