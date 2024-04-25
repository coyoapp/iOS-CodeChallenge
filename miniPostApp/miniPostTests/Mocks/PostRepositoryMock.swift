//
//  PostRepositoryMock.swift
//  miniPostTests
//
//  Created by Amine Hajri on 25.04.24.
//

import Foundation
import Combine
@testable import miniPost

final class PostRepositoryMock: PostRepositoryProtocol {
    func getPosts() -> AnyPublisher<[Post], any Error> {
        Just(MockedDataSource.posts)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
