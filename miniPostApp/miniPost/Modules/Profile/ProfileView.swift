import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel

    var body: some View {
        ZStack(alignment: .center) {
            if let user = viewModel.user {
                VStack(alignment: .center, spacing: 8) {
                    Text(user.name)
                        .font(.title)
                        .padding()
                    HStack {
                        Image(systemName: "phone")
                            .imageScale(.large)
                        Text(user.phone)
                    }
                    HStack {
                        Image(systemName: "globe")
                            .imageScale(.large)
                        Text(user.website)
                    }
                    Text("Customer ID: \(user.userHash())")
                    Spacer()
                }
            } else {
                ProgressView()
            }
        }
        .navigationTitle(viewModel.navigationTitle)
        .onAppear {
            viewModel.onAppear()
        }
    }
}

#Preview {
    let user = User(
        id: 1,
        name: "name",
        username: "username",
        email: "email",
        address: .init(
            street: "street",
            suite: "suite",
            city: "city",
            zipcode: "zipcode"
        ),
        phone: "phone",
        website: "website",
        company: .init(
            name: "name",
            catchPhrase: "catchPhrase",
            bs: "bs"
        )
    )
    return ProfileView(viewModel: .init(user: user))
}
