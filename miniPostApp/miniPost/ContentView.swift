import SwiftUI

struct MainMenuItem: Identifiable {
    let id: UUID = UUID()
    let name: String
    let image: String
}

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
        case "Profile": return AnyView(AppModules.modules.profileModule?.getView())
        default: return AnyView(PostsView())
        }
    }

    var body: some View {
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
}

struct DetailView: View {
    let item: MainMenuItem

    var body: some View {
        VStack {
            Text(item.name)
                .font(.title)
            Spacer()
        }
        .navigationTitle(item.name)
    }
}

struct UsersListView: View {
    var body: some View {
        MyUIKitView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
