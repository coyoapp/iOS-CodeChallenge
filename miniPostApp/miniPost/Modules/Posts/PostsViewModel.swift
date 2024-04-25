//
//  PostsViewModel.swift
//  miniPost
//
//  Created by Amine Hajri on 25.04.24.
//

import Foundation
import Combine

final class PostsViewModel: ObservableObject {
    @Inject private var postRepository: PostRepositoryProtocol
    @Inject private var userRepository: UserRepositoryProtocol
    @Published private(set) var posts = [Post]()
    private var cancellables = Set<AnyCancellable>()
    
    func getPosts() {
        var userNames = [Int: String]()
        var posts = [Post]()
        
        let usersPublisher = userRepository.getUsers().receive(on: DispatchQueue.main)
        let postsPublisher = postRepository.getPosts().receive(on: DispatchQueue.main)
        
        Publishers.Zip(usersPublisher, postsPublisher)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            }, receiveValue: { [self] (users, apiPosts) in
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
                
                self.posts = posts
            })
            .store(in: &cancellables)
    }
}
