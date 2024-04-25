//
//  UserAPIHandler.swift
//  miniPost
//
//  Created by Amine Hajri on 25.04.24.
//

import Foundation
import Combine

final class UserAPIHandler: UserAPIHandlerProtocol {
    func performUsersListAPICall() -> AnyPublisher<[User], Error> {
        let url = URL(string: APIUrls.fetchUsersUrl)!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: [User].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func performUserDetailAPICall(id: String) -> AnyPublisher<User, Error> {
        let url = URL(string: APIUrls.fetchUserByIdUrl + id)!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: User.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
