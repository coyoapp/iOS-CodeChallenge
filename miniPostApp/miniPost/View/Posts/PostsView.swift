//
//  PostsView.swift
//  miniPost
//
//  Created by Karthik Ravikumar on 01/05/2024.
//

import SwiftUI

struct PostsView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    var body: some View {
            VStack {
                List(appViewModel.postsViewModel.postList){ post in
                    PostsRow(postList: post)
                }
            }
            .navigationTitle("Posts")
        }
}

struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}
