//
//  PostsViewModelTests.swift
//  miniPostTests
//
//  Created by Triet Le on 23.4.2024.
//

import XCTest
@testable import miniPost

final class PostsViewModelTests: XCTestCase {
    @MainActor
    func testViewModelHasError() async {
        let viewModel = PostsViewModel(
            postService: PostServiceFail(),
            userService: UserServiceFail()
        )
        XCTAssert(viewModel.isLoading == true)
        XCTAssert(viewModel.showError == false)

        viewModel.onAppear()
        try? await Task.sleep(nanoseconds: UInt64(2 * 1_000_000_000))

        XCTAssert(viewModel.isLoading == false)
        XCTAssert(viewModel.showError == true)
        XCTAssert(viewModel.uiModels.isEmpty == true)
    }

    @MainActor
    func testViewModelHasValidPost() async {
        let viewModel = PostsViewModel(
            postService: PostServiceSuccess(),
            userService: UserServiceSuccess()
        )
        XCTAssert(viewModel.isLoading == true)
        XCTAssert(viewModel.showError == false)

        viewModel.onAppear()
        try? await Task.sleep(nanoseconds: UInt64(2 * 1_000_000_000))

        XCTAssert(viewModel.isLoading == false)
        XCTAssert(viewModel.showError == false)
        XCTAssert(viewModel.uiModels.isEmpty == false)
        XCTAssert(viewModel.uiModels.first?.author == "John Doe")
    }
}
