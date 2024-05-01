import SwiftUI

struct UsersListView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @State private var isShowingAlert = false
    @State private var selectedUser: User?
    var body: some View {
        
        VStack {
            
            List(appViewModel.usersListViewModel.userList){ user in
                Section {
                    UserListRow(userList: user)
                        .listRowBackground(Color(.gray).edgesIgnoringSafeArea([.leading, .trailing]))
                }
                .onTapGesture {
                    selectedUser = user
                    isShowingAlert = true
                }
            }
            .listStyle(.grouped)
            .alert(isPresented: $isShowingAlert) {
                Alert(title: Text(selectedUser?.name ?? ""), message: Text(selectedUser?.phone ?? ""), dismissButton: .default(Text("Close")))
            }
        }
        .navigationTitle("Users")
        
    }
}
