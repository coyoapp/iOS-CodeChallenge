import SwiftUI

struct MainMenuView: View {
    private let items: [MainMenuItem] = [
        MainMenuItem(name: "Posts", image: "message"),
        MainMenuItem(name: "Users", image: "person.3"),
        MainMenuItem(name: "Profile", image: "person.text.rectangle")
    ]

    var body: some View {
        // TODO: Migrate to NavigationStack
        NavigationView {
            List(items) { mainMenuItem in
                
                NavigationLink(destination: getDestinationView(mainMenuItem)) {
                    HStack {
                        Image(systemName: mainMenuItem.image)
                            .imageScale(.large)
                        Text(mainMenuItem.name)
                            .font(.title)
                            .padding()
                    }
                }
            }
            .navigationTitle("Main Menu")
        }
    }
    
    private func getDestinationView(_ item: MainMenuItem) -> some View {
        switch item.name {
        case "Posts": AnyView(PostsView())
        case "Users": AnyView(UsersListView())
        case "Profile": AnyView(AppModules.modules.profileModule?.getView())
        default: AnyView(PostsView())
        }
    }
}

#if DEBUG
#Preview {
    MainMenuView()
}
#endif
