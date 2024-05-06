//
//  UserDTO.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 6/5/24.
//

import Foundation

struct UserDTO: Decodable {
    let id: Int
    let name: String
    let phone: String
    let website: String
}
