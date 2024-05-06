//
//  UsersRequest.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 6/5/24.
//

import Foundation

struct UsersRequest: NetworkRequest {
    var path: String = "/users"
    var parameters: [String : String] = [:]
}
