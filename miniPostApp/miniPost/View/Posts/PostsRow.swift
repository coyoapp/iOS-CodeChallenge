import SwiftUI

struct PostsRow: View {
    var postList: PostList
    var body: some View {
        VStack(alignment:.leading, spacing: 10) {
            Text(postList.details.title)
                .font(.headline)
            Text(postList.author)
                .font(.subheadline)
            Text(postList.details.body)
                .font(.body)
        }
        .padding()
    }
}

