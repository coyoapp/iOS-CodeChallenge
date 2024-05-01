import Foundation

struct PostList: Identifiable {
    let id = UUID()
    let details: Post
    let author: String
}
