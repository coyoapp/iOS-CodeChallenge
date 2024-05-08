//
//  Post+PostDisplay.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 8/5/24.
//

import Foundation

extension Post {
    var toDisplay: PostDisplay {
        .init(
            id: self.id,
            authorName: self.authorName,
            title: self.title,
            body: self.body
        )
    }
}
