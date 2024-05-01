import Foundation
import Collections
import Combine

final class UsersListViewModel: ObservableObject {
    @Published var userList: [User] = []
    private var cancellables = Set<AnyCancellable>()

    private let usersListService: NetworkProtocol
    
    init(usersListService: NetworkProtocol) {
        self.usersListService = usersListService
        fetchUserList()
    }
    
    func fetchUserList() {
        usersListService.fetchUsersListService().sink { completion in
            switch completion {
            case .failure(let error):
                print("Error fetching posts:", error.localizedDescription)
            case .finished:
                print("Finished receiving posts")
            }
        } receiveValue: { [weak self] result in
            self?.userList = result
        }
        .store(in: &cancellables)
    }

}
