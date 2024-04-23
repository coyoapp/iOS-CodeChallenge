//
//  UsersView.swift
//  miniPost
//
//  Created by Triet Le on 23.4.2024.
//

import SwiftUI

struct UsersView: View {
    @StateObject private var viewModel = UsersViewModel()

    var body: some View {
        ZStack(alignment: .center) {
            if viewModel.isLoading {
                ProgressView()
            } else {
                List {
                    ForEach(viewModel.users, id: \.self) { user in
                        userView(user)
                    }
                }
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .alert("Something went wrong", isPresented: $viewModel.showError) {
            Button("Retry", role: .cancel) {
                viewModel.retry()
            }
        }
        .navigationTitle("Users")
    }

    @ViewBuilder
    private func userView(_ user: User) -> some View {
        NavigationLink(destination: ProfileView(viewModel: .init(user: user))) {
            VStack(alignment: .leading, spacing: 8) {
                Text(user.name)
                    .font(.title)
                    .fontWeight(.black)

                Text(verbatim: user.email)
                    .fontWeight(.semibold)

                Text(user.address.formattedAddress)
            }
        }
    }
}

#Preview {
    UsersView()
}
