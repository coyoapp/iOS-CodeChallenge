//
//  UserDTO+User.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 7/5/24.
//

import Foundation

extension UserDTO {
    var toDomain: User {
        .init(
            id: self.id,
            name: self.name,
            phone: self.phone,
            website: self.website
        )
    }
}
