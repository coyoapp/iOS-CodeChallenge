//
//  PostServiceImpl.swift
//  miniPost
//
//  Created by Dmitry Suvorov on 28.4.2024.
//

import Foundation

final class PostServiceImpl: PostService {
    private let session: URLSession
    private let jsonDecoder = JSONDecoder()

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    func fetchPostList() async throws -> [PostRemote] {
        let url = Const.apiUrl.appendingPathComponent("posts")
        let (data, _) = try await session.data(from: url)
        return try jsonDecoder.decode([PostRemote].self, from: data)
    }
}
