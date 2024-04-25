//
//  UsersViewModel.swift
//  miniPost
//
//  Created by Amine Hajri on 25.04.24.
//

import Foundation
import Combine

final class UsersViewModel {
    @Inject private var userRepository: UserRepositoryProtocol
    @Published private(set) var users = [User]()
    private var cancellables = Set<AnyCancellable>()
    
    func getUsers() {
        userRepository.getUsers()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                default:
                    break
                }
            } receiveValue: { [self] in
                users = $0
            }.store(in: &cancellables)
    }
}
