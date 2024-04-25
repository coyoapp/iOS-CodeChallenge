//
//  PostsViewModelTests.swift
//  miniPostTests
//
//  Created by Amine Hajri on 25.04.24.
//

import XCTest
import Combine
@testable import miniPost

final class PostsViewModelTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    private var postsViewModel: PostsViewModel?
    
    override func setUp() {
        @Provider var postRepository = PostRepositoryMock() as PostRepositoryProtocol
        postsViewModel = PostsViewModel()
    }
    
    func testGetPosts() {
        postsViewModel?.getPosts()
        postsViewModel?.$posts
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink(receiveValue: { posts in
                XCTAssertEqual(posts, MockedDataSource.posts)
            }).store(in: &cancellables)
    }
}
