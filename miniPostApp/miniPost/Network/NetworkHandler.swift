import Foundation
import Combine

final class NetworkHandler: NetworkProtocol {
    
    private static let baseUrl = "https://jsonplaceholder.typicode.com/"
    
    func fetchPostsService() -> AnyPublisher<[Post], Error> {
        return fetchData(from: "posts")
    }
    
    func fetchUsersListService() -> AnyPublisher<[User], Error> {
        return fetchData(from: "users")
    }
    
    func fetchUserProfileService(id: String) -> AnyPublisher<User, Error> {
        return fetchData(from: "/users/\(id)")
    }
    
    private func fetchData<T: Decodable>(from endpoint: String) -> AnyPublisher<T, Error> {
        guard let url = URL(string: NetworkHandler.baseUrl + endpoint) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}

