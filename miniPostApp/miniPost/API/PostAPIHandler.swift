//
//  PostAPIHandler.swift
//  miniPost
//
//  Created by Amine Hajri on 25.04.24.
//

import Foundation
import Combine

final class PostAPIHandler: PostAPIHandlerProtocol {
    func fetchPosts() -> AnyPublisher<[APIPost], Error> {
        let url = URL(string: APIUrls.fetchPostsUrl)!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: [APIPost].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
