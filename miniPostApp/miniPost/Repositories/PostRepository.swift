//
//  PostRepository.swift
//  miniPost
//
//  Created by Amine Hajri on 25.04.24.
//

import Foundation
import Combine

final class PostRepository: PostRepositoryProtocol {
    private let postAPI: PostAPIHandlerProtocol
    
    init(postAPI: PostAPIHandlerProtocol) {
        self.postAPI = postAPI
    }
    
    func getPosts() -> AnyPublisher<[APIPost], any Error> {
        return postAPI.fetchPosts()
    }
}
