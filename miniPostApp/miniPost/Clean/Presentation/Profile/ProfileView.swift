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
        
        ScrollView {
            VStack {
                if case let .loaded(userDisplay) = viewModel.state {
                    VStack {
                        ProfileCardView(userDisplay: userDisplay)
                        Spacer()
                    }
                    .navigationTitle(userDisplay.name)
                }
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
        .loadingState(viewModel.state)
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
