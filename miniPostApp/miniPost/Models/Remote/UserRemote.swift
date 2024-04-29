//
//  UserRemote.swift
//  miniPost
//
//  Created by Dmitry Suvorov on 29.4.2024.
//

import Foundation

struct UserRemote: Decodable {
    let id: Int
    let name: String
    let phone: String
    let website: String
}
