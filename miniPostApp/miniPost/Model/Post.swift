import Foundation

struct Post: Decodable, Hashable {
    let id: Int
    var userId: Int
    let title: String
    let body: String
}

typealias Posts = [Post]
