import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        VStack {
            Text(viewModel.user?.name ?? "")
                .font(.title)
                .padding()
            HStack {
                Image(systemName: "phone")
                    .imageScale(.large)
                Text(viewModel.user?.phone ?? "")
            }
            HStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                Text(viewModel.user?.website ?? "")
            }
            Text("Customer ID: " + (viewModel.user?.hash ?? ""))
            Spacer()
        }
        .onAppear {
            viewModel.onAppear()
        }
        .navigationTitle("My profile")
    }
}

#Preview {
    ProfileView(
        viewModel: ProfileViewModel(
            userService: UserServiceMock()!
        )
    )
}
