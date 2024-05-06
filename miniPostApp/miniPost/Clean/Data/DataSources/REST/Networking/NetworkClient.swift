import Foundation

protocol NetworkClient {
    func perform<T: Decodable>(request: NetworkRequest) async throws -> T
}

struct ApiClient: NetworkClient {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func perform<T: Decodable>(request: NetworkRequest) async throws -> T {
        guard let url = request.url else {
            throw DataError.malformedUrl
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw DataError.noHTTPProtocol
        }
        
        guard httpResponse.statusCode == 200 else {
            throw DataError.network(.error(for: httpResponse.statusCode))
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("[ApiClient] Error: \(String(describing: error))")
            
            if let responseDataString = String(data: data, encoding: .utf8) {
                print("[ApiClient] Failure when decoding data into '\(T.self)'. Data: \(responseDataString)")
            }
            
            throw error
        }
    }
}
