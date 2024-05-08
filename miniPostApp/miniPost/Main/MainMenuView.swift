import SwiftUI

struct MainMenuView: View {
    var body: some View {
        TabView {
            NavigationStack {
                PostsViewFactory.make()
            }
            .tabItem {
                Label("Posts", systemImage: "message")
            }
            
            NavigationStack {
                UsersListView()
            }
            .tabItem {
                Label("Users", systemImage: "person.3")
            }
            
            NavigationStack {
                ProfileViewFactory.make()
            }
            .tabItem {
                Label("Profile", systemImage: "person.text.rectangle")
            }
        }
    }
}

#if DEBUG
#Preview {
    MainMenuView()
}
#endif
