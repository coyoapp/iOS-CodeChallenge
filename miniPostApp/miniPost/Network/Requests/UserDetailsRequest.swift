//
//  UserDetailsRequest.swift
//  miniPost
//
//  Created by Triet Le on 23.4.2024.
//

import Foundation

struct UserDetailsRequest: APIRequest {
    let path = AppPantry.API.fetchUsersPath
    let userId: String

    func execute() async throws -> Response {
        let urlString = "\(AppPantry.API.baseURLString + path)/\(userId)"
        let url = URL(string: urlString)

        guard let url else {
            throw APIError.malformedURLRequest
        }

        //create a new urlRequest passing the url
        let request = URLRequest(url: url)

        //run the request and retrieve both the data and the response of the call
        let (data, _) = try await URLSession.shared.data(for: request)

        //checks if there are errors regarding the HTTP status code and decodes using the passed struct
        return try JSONDecoder().decode(Response.self, from: data)
    }
}

extension UserDetailsRequest {
    typealias Response = User
}
