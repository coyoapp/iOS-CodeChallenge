//
//  ProfileCardView.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 8/5/24.
//

import SwiftUI

struct ProfileCardView: View {
    let userDisplay: ProfileViewModel.UserDisplay
    
    var body: some View {
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

#if DEBUG
#Preview {
    ProfileCardView(
        userDisplay: .init(
            name: "John",
            phone: "+55 555 555 555",
            website: "http://johndoe.com",
            userHash: "#HASH"
        )
    )
}
#endif
