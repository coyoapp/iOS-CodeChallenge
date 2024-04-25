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
    private let userAPI: UserAPIHandlerProtocol
    
    init(postAPI: PostAPIHandlerProtocol, userAPI: UserAPIHandlerProtocol) {
        self.postAPI = postAPI
        self.userAPI = userAPI
    }
    
    func getPosts() -> AnyPublisher<[Post], any Error> {
        var userNames = [Int: String]()
        var posts = [Post]()
        
        let usersPublisher = userAPI.performUsersListAPICall()
        let postsPublisher = postAPI.fetchPosts()
        
        return Publishers.Zip(usersPublisher, postsPublisher)
            .map{ (users, apiPosts) in
                userNames = users.reduce(into: [Int: String]()) { names, user in
                    names[user.id] = user.name
                }
                
                posts = apiPosts.map { apiPost in
                    Post(
                        id: apiPost.id,
                        authorName: userNames[apiPost.userId] ?? "Unknown",
                        title: apiPost.title,
                        body: apiPost.body
                    )
                }
                return posts
            }
            .eraseToAnyPublisher()
    }
}
