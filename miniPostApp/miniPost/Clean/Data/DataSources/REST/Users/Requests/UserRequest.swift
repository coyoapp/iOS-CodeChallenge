//
//  UserRequest.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 6/5/24.
//

import Foundation

struct UserRequest: NetworkRequest {
    var path: String {
        "/users/\(id)"
    }
    var parameters: [String : String] = [:]
    
    let id: String
}
