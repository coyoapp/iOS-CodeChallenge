//
//  APIError.swift
//  miniPost
//
//  Created by Triet Le on 23.4.2024.
//

import Foundation

enum APIError: CustomNSError {
    case malformedURLRequest
    case error(Error)
}
