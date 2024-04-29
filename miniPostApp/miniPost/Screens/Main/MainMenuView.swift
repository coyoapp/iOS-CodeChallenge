import SwiftUI

struct MainMenuView: View {
    @ObservedObject var viewModel: MainMenuViewModel

    var body: some View {
        NavigationStack {
            List(viewModel.items) { item in
                NavigationLink(
                    destination: { viewModel.destinationView(for: item) },
                    label: {
                        HStack {
                            Image(systemName: item.image)
                                .imageScale(.large)
                                .frame(minWidth: 46)
                            Text(item.name)
                                .font(.title)
                                .padding()
                            Spacer()
                        }
                    }
                )
            }
            .navigationTitle("Main Menu")
        }
    }
}

#Preview {
    MainMenuView(
        viewModel: MainMenuViewModel(
            appServices: AppServices(
                postService: PostServiceImpl(),
                userService: UserServiceImpl()
            )
        )
    )
}
