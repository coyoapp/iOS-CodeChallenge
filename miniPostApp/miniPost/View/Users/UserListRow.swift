//
//  UserListRow.swift
//  miniPost
//
//  Created by Karthik Ravikumar on 01/05/2024.
//

import SwiftUI

struct UserListRow: View {
    var userList: User
    var body: some View {
        VStack(alignment: .center) {
            Text(userList.name)
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(height: 70)
    }
}

