import SwiftUI

struct MainMenuRow: View {
    var item: MainMenuItem
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: item.image)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
            Text(item.name)
                .font(.title)
                .padding()
            
        }
        .padding([.top, .bottom], 8)
    }
}
