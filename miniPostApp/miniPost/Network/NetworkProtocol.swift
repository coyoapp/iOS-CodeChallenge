import Combine

protocol NetworkProtocol {
    func fetchPostsService() -> AnyPublisher<[Post], Error>
    func fetchUsersListService() -> AnyPublisher<[User], Error>
    func fetchUserProfileService(id: String) -> AnyPublisher<User, Error>
}
