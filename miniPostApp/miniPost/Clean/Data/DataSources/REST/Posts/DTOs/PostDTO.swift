//
//  PostDTO.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 6/5/24.
//

import Foundation

struct PostDTO: Decodable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
}
