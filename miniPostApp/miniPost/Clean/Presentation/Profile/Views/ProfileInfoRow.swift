//
//  ProfileInfoRow.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 8/5/24.
//

import SwiftUI

struct ProfileInfoRow: View {
    let iconName: String
    let text: String
    
    var body: some View {
        HStack(spacing: 14) {
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
    ProfileInfoRow(iconName: "globe", text: "John")
}
#endif
