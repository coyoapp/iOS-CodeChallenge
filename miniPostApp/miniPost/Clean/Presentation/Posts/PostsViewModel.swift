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
    var posts: [PostDisplay] = []
    
    private let getAllPostsUseCase: GetAllPostsUseCase
    
    init(getAllPostsUseCase: GetAllPostsUseCase) {
        self.getAllPostsUseCase = getAllPostsUseCase
    }
    
    func onAppear() async {
        let posts = await getAllPostsUseCase()
        
        await MainActor.run {
            withAnimation {
                self.posts = posts.map { $0.toDisplay }
            }
        }
    }
}
