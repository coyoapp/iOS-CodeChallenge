//
//  APIRequest.swift
//  miniPost
//
//  Created by Triet Le on 23.4.2024.
//

import Foundation

protocol APIRequest {
    associatedtype Response: Decodable

    func execute() async throws -> Response
}
