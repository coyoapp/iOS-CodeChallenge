//
//  PostsView.swift
//  miniPost
//
//  Created by Robert Lang on 22/3/24.
//

import SwiftUI

struct PostsView: View {
    @State private var posts: [Post] = []
    
    var body: some View {
        VStack {
            if posts.isEmpty {
                Text("Loading posts...")
            } else {
                List(posts, id: \.id) { post in
                    VStack(alignment: .leading) {
                        Text(post.title)
                            .font(.headline)
                        Text("By "+post.authorName)
                            .font(.subheadline)
                        Text(post.body)
                            .font(.body)
                    }
                }
            }
        }
        .onAppear(perform: fetchPosts)
    }
    
    private func fetchPosts() {
        
        struct APIPost: Codable {
            let id: Int
            let title: String
            let body: String
            let userId: Int
        }
        
        // TODO: HIGH: Beware of the Task initiated from the DataTask
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([APIPost].self, from: data) {
                    DispatchQueue.main.async {
                        self.posts = decodedResponse.map({ APIPost in
                            let post = Post(id: APIPost.id, authorName: String(APIPost.userId), title: APIPost.title, body: APIPost.body)
                            return post
                        })
                        for (index, post) in self.posts.enumerated() {
                            Task {
                                let userInfo = await getUser(id: post.authorName) // This call triggers another HTTP request
                                self.posts[index].authorName = userInfo.name
                            }
                        }
                    }
                    return
                }
            }
            print("Fetch failed")
        }.resume()
    }
}
