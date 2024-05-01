import Foundation
import Combine

class AppViewModel: ObservableObject {
    let postsViewModel = PostsViewModel(postsService: NetworkHandler(), userListService: NetworkHandler())
    let usersListViewModel = UsersListViewModel(usersListService: NetworkHandler())
    let profileViewModel = ProfileViewModel(userProfileService: NetworkHandler())
}
