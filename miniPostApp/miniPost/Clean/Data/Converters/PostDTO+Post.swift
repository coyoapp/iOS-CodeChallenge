//
//  PostDTO+Post.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 6/5/24.
//

import Foundation

extension PostDTO {
    func toDomain(author: String) -> Post {
        .init(
            id: self.id,
            authorName: author,
            title: self.title,
            body: self.body
        )
    }
}
