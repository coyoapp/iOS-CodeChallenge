import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    var body: some View {
        ZStack {
            Color(red:0.98, green:0.76, blue:0.67)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text(appViewModel.profileViewModel.userProfile?.name ?? "")
                    .font(Font.custom("Pacifico-Regular", size: 40))
                    .bold()
                    .foregroundColor(.black)
                Divider()
                InfoView(text: appViewModel.profileViewModel.userProfile?.phone ?? "Leanne Graham", imageName: "phone.fill")
                InfoView(text: appViewModel.profileViewModel.userProfile?.website ?? "kale.biz", imageName: "globe")
                InfoView(text: "Customer ID: \(appViewModel.profileViewModel.userHash)", imageName: nil)
                Spacer()
            }
            .navigationTitle("Profile")
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
