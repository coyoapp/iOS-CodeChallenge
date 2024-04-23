import SwiftUI

struct MainMenuView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(MenuItem.allCases, id: \.self) {
                        menuItemView($0)
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Main Menu")
        }
    }

    @ViewBuilder
    private func menuItemView(_ menuItem: MenuItem) -> some View {
        NavigationLink(destination: menuItem.destination) {
            HStack(spacing: 16) {
                Image(systemName: menuItem.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)

                Text(menuItem.title)
                    .font(.title)
            }
            .padding(.vertical)
        }
    }
}

#Preview {
    MainMenuView()
}
