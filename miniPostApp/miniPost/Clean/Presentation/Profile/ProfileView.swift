//
//  ProfileView.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 7/5/24.
//

import SwiftUI

struct ProfileView: View {
    @State var viewModel: ProfileViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.userDisplay.name)
                .font(.title)
                .padding()
            HStack {
                Image(systemName: "phone")
                    .imageScale(.large)
                Text(viewModel.userDisplay.phone)
            }
            HStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                Text(viewModel.userDisplay.website)
            }
            Text("Customer ID: " + viewModel.userDisplay.userHash)
            Spacer()
        }
        .navigationTitle("My profile")
        .task {
            await viewModel.fetchInfo()
        }
    }
}

#if DEBUG
#Preview {
    ProfileView(
        viewModel: .init(getProfileUseCase: GetProfileInformationUseCasePreviewMock())
    )
}
#endif
