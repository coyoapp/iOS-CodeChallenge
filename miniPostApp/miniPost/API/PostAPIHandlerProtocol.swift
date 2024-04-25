//
//  PostAPIHandlerProtocol.swift
//  miniPost
//
//  Created by Amine Hajri on 25.04.24.
//

import Foundation
import Combine

protocol PostAPIHandlerProtocol {
    func fetchPosts() -> AnyPublisher<[APIPost], Error>
}
