import Foundation

protocol NetworkRequest {
    var path: String { get }
    var parameters: [String: String] { get }
    var url: URL? { get }
}

extension NetworkRequest {
    var endpoint: String {
        "https://jsonplaceholder.typicode.com\(path)"
    }
    
    var url: URL? {
        guard var requestUrl = URL(string: endpoint) else { return nil }
        var queryItems: [URLQueryItem] = []
        
        for (key, value) in parameters {
            queryItems.append(
                URLQueryItem(name: key, value: value)
            )
        }
        
        if !queryItems.isEmpty {
            requestUrl.append(queryItems: queryItems)
        }
        
        return requestUrl
    }
}
