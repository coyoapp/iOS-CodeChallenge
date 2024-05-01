import SwiftUI

struct MainMenuView: View {

    let items: [MainMenuItem] = [
        MainMenuItem(name: "Posts", image: "message"),
        MainMenuItem(name: "Users", image: "person.3"),
        MainMenuItem(name: "Profile", image: "person.text.rectangle")
    ]

    func getDestinationView(_ item: MainMenuItem) -> some View {
        switch item.name {
        case "Posts": return AnyView(PostsView())
        case "Users": return AnyView(UsersListView())
        case "Profile": return AnyView(ProfileView())
        default: return AnyView(PostsView())
        }
    }

    var body: some View {
        NavigationView {
            List(items) { mainMenuItem in
                
                NavigationLink(destination: getDestinationView(mainMenuItem)) {
                    MainMenuRow(item: mainMenuItem)
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("Main Menu")
        }
    }
}
