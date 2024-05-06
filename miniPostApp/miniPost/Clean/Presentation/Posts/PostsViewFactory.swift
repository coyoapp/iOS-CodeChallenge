//
//  PostsViewFactory.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 7/5/24.
//

import Foundation

enum PostsViewFactory {
    static func make() -> PostsView {
        let postsRepository = PostsRepositoryFactory.make()
        let getAllPostsUseCase = GetAllPostsUseCaseImplementation(postsRepository: postsRepository)
        let viewModel = PostsViewModel(getAllPostsUseCase: getAllPostsUseCase)
        
        return PostsView(viewModel: viewModel)
    }
}
