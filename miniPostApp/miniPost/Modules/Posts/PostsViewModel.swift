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
}
