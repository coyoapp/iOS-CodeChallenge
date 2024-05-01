import SwiftUI

@main
struct UICheckApp: App {
    @StateObject var appViewModel = AppViewModel()
    var body: some Scene {
        WindowGroup {
            MainMenuView()
                .environmentObject(appViewModel)
        }
    }
}
