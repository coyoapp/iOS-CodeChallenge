//
//  PostRemote.swift
//  miniPost
//
//  Created by Dmitry Suvorov on 28.4.2024.
//

import Foundation

struct PostRemote: Decodable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
}
