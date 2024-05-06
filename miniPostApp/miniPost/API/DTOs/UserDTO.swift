//
//  UserDTO.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 6/5/24.
//

import Foundation

// TODO: Consider replacing Codable by Decodable only
struct UserDTO: Codable {
    let id: Int
    let name: String
    let phone: String
    let website: String
}
