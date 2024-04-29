//
//  UserListView.swift
//  miniPost
//
//  Created by Dmitry Suvorov on 29.4.2024.
//

import SwiftUI

struct UserListView: View {
    @ObservedObject var viewModel: UserListViewModel

    var body: some View {
        VStack {
            if viewModel.users.isEmpty {
                Text("Loading posts...")
            } else {
                List(viewModel.users, id: \.id) { user in
                    Text(user.name)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50)
                        .background(Color(uiColor: .lightGray))
                        .padding(5)
                        .onTapGesture {
                            viewModel.tappedItem(user)
                        }
                }
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .sheet(isPresented: $viewModel.isDetailsShown) {
            if let shownUser = viewModel.shownUser {
                ProfileView(viewModel: ProfileViewModel(user: shownUser))
            }
        }
    }
}

#Preview {
    UserListView(viewModel: UserListViewModel(userService: UserServiceImpl()))
}
