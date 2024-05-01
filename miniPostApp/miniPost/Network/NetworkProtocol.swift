import Combine

protocol NetworkProtocol {
    func fetchPostsService() -> AnyPublisher<[Post], Error>
    func fetchUsersListService() -> AnyPublisher<[User], Error>
    func fetchUserProfileService(id: String) -> AnyPublisher<User, Error>
}

class MockAPIClient: NetworkProtocol {
    
    func fetchUsersListService() -> AnyPublisher<[User], Error> {
        // Simulate API response with mock data
        let usersList: [User] = [
            User(id: 1, name: "Leanne Graham", phone: "92998-3874", website: "hildegard.org"),
            User(id: 2, name: "Ervin Howell", phone: "010-692-6593 x09125", website: "anastasia.net"),
        ]
        return Just(usersList)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func fetchUserProfileService(id: String) -> AnyPublisher<User, Error> {
        
        // Simulate API response with mock data
        let profile: User = User(id: 1, name: "Leanne Graham", phone: "92998-3874", website: "hildegard.org")
        return Just(profile)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
        

    
    func fetchPostsService() -> AnyPublisher<[Post], Error> {
        // Simulate API response with mock data
        let posts: [Post] = [
            Post(id: 1, userId: 1, title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"),
            Post(id: 2, userId: 1, title: "qui est esse", body: "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla")
        ]
        return Just(posts)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

}
