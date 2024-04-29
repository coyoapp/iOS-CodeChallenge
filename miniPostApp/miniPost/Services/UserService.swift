//
//  UserService.swift
//  miniPost
//
//  Created by Dmitry Suvorov on 28.4.2024.
//

import Foundation

protocol UserService {
    func fetchUserList() async throws -> [UserRemote]
    func fetchUserDetail(id: Int) async throws -> UserRemote
}
