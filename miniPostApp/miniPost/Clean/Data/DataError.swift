import Foundation

enum DataError: Error {
    enum Network {
        case client
        case redirection
        case server
        case unknown
        
        static func error(for statusCode: Int) -> Network {
            return switch statusCode {
            case 300..<399:
                Self.redirection
            case 400..<499:
                Self.client
            case 500..<599:
                Self.server
            default:
                Self.unknown
            }
        }
    }
    
    case unexpectedFailure
    case malformedUrl
    case network(_ network: Network)
    case noHTTPProtocol
}
