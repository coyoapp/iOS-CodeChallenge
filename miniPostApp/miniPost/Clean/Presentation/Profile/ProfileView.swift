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
                        cardView(with: userDisplay)
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
    
    private func cardView(with userDisplay: ProfileViewModel.UserDisplay) -> some View {
        HStack(spacing: 25) {
            VStack(alignment: .leading) {
                ProfileInfoRow(iconName: "phone", text: userDisplay.phone)
                ProfileInfoRow(iconName: "globe", text: userDisplay.website)
                ProfileInfoRow(iconName: "person.text.rectangle", text: userDisplay.userHash)
            }
            
            Spacer()
            
            Image(systemName: "person.crop.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 90)
                .foregroundStyle(.gray.gradient)
        }
    }
}

struct ProfileInfoRow: View {
    let iconName: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25)
            
            Text(text)
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
