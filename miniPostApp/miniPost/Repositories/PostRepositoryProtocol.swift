//
//  PostRepositoryProtocol.swift
//  miniPost
//
//  Created by Amine Hajri on 25.04.24.
//

import Foundation
import Combine

protocol PostRepositoryProtocol {
    func getPosts() -> AnyPublisher<[APIPost], Error>
}
