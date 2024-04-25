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
    @Published private(set) var posts = [Post]()
    private var cancellables = Set<AnyCancellable>()
    
    func getPosts() {
        postRepository.getPosts()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                default:
                    break
                }
            } receiveValue: {
                self.posts = $0
            }.store(in: &cancellables)
    }
}
