//
//  miniPostTests.swift
//  miniPostTests
//
//  Created by Robert Lang on 21/3/24.
//

import XCTest
import Combine
import Collections
@testable import miniPost

final class miniPostTests: XCTestCase {

    var profileVM: ProfileViewModel!
    
    private var service: MockAPIClient!

    override func setUpWithError() throws {
        super.setUp()
        service = MockAPIClient()
        profileVM = ProfileViewModel(userProfileService: service)
    }
    override func tearDownWithError() throws {
        super.tearDown()
    }

    func testUserHash() throws {
        // given
        let user = User(id: 1, name: "John Doe", phone: "123-456", website: "test.local")
        // when
        let userHash = profileVM.calculateUserHash(name: user.name, phone: user.phone, website: user.website)
        // then
        XCTAssertEqual(userHash, "JoDo579test")

    }
    
    func testGetPosts() {
        // given
        let expectation = XCTestExpectation(description: "Fetching Posts from API")
        var receivedPost: [Post]?
        // when
        let cancellable = service.fetchPostsService().sink(
            receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("API request failed with error: \(error)")
                }
                expectation.fulfill()
            },
            receiveValue: { post in
                receivedPost = post
            }
        )
        wait(for: [expectation], timeout: 5.0)
        // then
        XCTAssertNotNil(receivedPost)
        XCTAssertEqual(receivedPost?.count, 2)
        cancellable.cancel()
    }
    
    func testGetUsers() {
        // given
        let expectation = XCTestExpectation(description: "Fetching Users List from API")
        var receivedUsers: [User]?
        // when
        let cancellable = service.fetchUsersListService().sink(
            receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("API request failed with error: \(error)")
                }
                expectation.fulfill()
            },
            receiveValue: { user in
                receivedUsers = user
            }
        )
        wait(for: [expectation], timeout: 5.0)
        // then
        XCTAssertNotNil(receivedUsers)
        XCTAssertEqual(receivedUsers?.count, 2)
        cancellable.cancel()
    }
    
    func testGetProfile() {
        // given
        let expectation = XCTestExpectation(description: "Fetching Profile from API")
        var receivedProfile: User?
        // when
        let cancellable = service.fetchUserProfileService(id: "1").sink(
            receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("API request failed with error: \(error)")
                }
                expectation.fulfill()
            },
            receiveValue: { profile in
                receivedProfile = profile
            }
        )
        wait(for: [expectation], timeout: 5.0)
        // then
        XCTAssertNotNil(receivedProfile)
        XCTAssertEqual(receivedProfile?.name, "Leanne Graham")
        XCTAssertEqual(receivedProfile?.phone, "92998-3874")
        XCTAssertEqual(receivedProfile?.website, "hildegard.org")
        cancellable.cancel()
    }
    
    func testGetPostList() {
        // given
        let expectation = XCTestExpectation(description: "Fetching Post with Author from API")
        var receivedPostList: [PostList]?
        // when
        let cancellable = service.fetchPostList().sink(
            receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("API request failed with error: \(error)")
                }
                expectation.fulfill()
            },
            receiveValue: { postList in
                receivedPostList = postList
            }
        )
        wait(for: [expectation], timeout: 5.0)
        // then
        XCTAssertNotNil(receivedPostList)
        cancellable.cancel()
    }
}


