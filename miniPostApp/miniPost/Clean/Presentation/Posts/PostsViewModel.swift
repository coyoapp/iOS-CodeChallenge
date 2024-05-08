//
//  PostsViewModel.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 6/5/24.
//

import Foundation
import SwiftUI

@Observable
class PostsViewModel {
    var state: ViewModelState<[PostDisplay]> = .idle
    
    private let getAllPostsUseCase: GetAllPostsUseCase
    
    init(getAllPostsUseCase: GetAllPostsUseCase) {
        self.getAllPostsUseCase = getAllPostsUseCase
    }
    
    func onAppear() async {
        withAnimation {
            state = .loading
        }
        
        let posts = await getAllPostsUseCase()
        
        await MainActor.run {
            withAnimation {
                state = .loaded(posts.map { $0.toDisplay })
            }
        }
    }
}
