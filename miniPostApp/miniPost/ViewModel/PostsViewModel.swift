import Foundation
import Collections
import Combine

final class PostsViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var postList: [PostList] = []
    private var cancellables = Set<AnyCancellable>()

    private let service: NetworkProtocol

    
    init(service: NetworkProtocol) {
        self.service = service
        fetchPosts()
    }
    
    func fetchPosts() {
        service.fetchPostsService().sink { completion in
            switch completion {
            case .failure(let error):
                print("Error fetching posts:", error.localizedDescription)
            case .finished:
                print("Finished receiving posts")
            }
        } receiveValue: { [weak self] result in
            self?.posts = result
            self?.fetchUserList()
        }
        .store(in: &cancellables)
    }
    
    func fetchUserList() {
        service.fetchUsersListService().sink { completion in
            switch completion {
            case .failure(let error):
                print("Error fetching posts:", error.localizedDescription)
            case .finished:
                print("Finished receiving posts")
            }
        } receiveValue: { [weak self] result in
            let res = self?.posts.map { post -> PostList in
                let author = result.first(where: { $0.id == post.userId })?.name ?? ""
                return PostList(details: post, author: author)
            }
            
            if let postList = res {
                self?.postList = postList
            }
        }
        .store(in: &cancellables)
    }

}
