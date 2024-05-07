//
//  PostsViewModelTests.swift
//  miniPostTests
//
//  Created by Víctor Barrios Sánchez on 7/5/24.
//
@testable import miniPost
import XCTest

final class PostsViewModelTests: XCTestCase {
    
    private var sut: PostsViewModel!
    private var getAllPostsUseCaseMock: GetAllPostsUseCaseMock!

    override func setUp() {
        super.setUp()
        
        getAllPostsUseCaseMock = GetAllPostsUseCaseMock()
        getAllPostsUseCaseMock.returnValue = [
            .init(id: 1, authorName: "John", title: "The Beginning", body: "Once upon a time...")
        ]
        
        sut = PostsViewModel(getAllPostsUseCase: getAllPostsUseCaseMock)
    }
    
    func testThatPostsAreLoaded_When_CallingOnAppear() async {
        await sut.onAppear()
        
        XCTAssertEqual(1, getAllPostsUseCaseMock.callAsFunctionCallsCount)
        XCTAssertEqual(1, sut.posts.count)
        XCTAssertEqual("John", sut.posts[0].authorName)
    }
}
