import SwiftUI

struct ProfileView: View {
    @ObservedObject private var profileViewModel = ProfileViewModel()
    private let userId = "4"
    
    var body: some View {
        VStack {
            Text(profileViewModel.userProfile?.name ?? "Unknown")
                .font(.title)
                .padding()
            HStack {
                Image(systemName: "phone")
                    .imageScale(.large)
                Text(profileViewModel.userProfile?.phone ?? "Unknown")
            }
            HStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                Text(profileViewModel.userProfile?.website ?? "Unknown")
            }
            Text("Customer ID: " + (profileViewModel.userProfile?.getUserHash() ?? "Unknown"))
            Spacer()
        }.navigationTitle("My profile")
            .onAppear(perform: { profileViewModel.getUser(id: userId) })
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
