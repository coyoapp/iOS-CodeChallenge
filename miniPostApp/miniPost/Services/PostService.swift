//
//  PostService.swift
//  miniPost
//
//  Created by Dmitry Suvorov on 28.4.2024.
//

import Foundation

protocol PostService {
    func fetchPostList() async throws -> [PostRemote]
}
