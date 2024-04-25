//
//  ProfileViewModel.swift
//  miniPost
//
//  Created by Amine Hajri on 25.04.24.
//

import Foundation
import Combine

final class ProfileViewModel: ObservableObject {
    @Inject private var userRepository: UserRepositoryProtocol
    @Published private(set) var userProfile: User?
    private var cancellables = Set<AnyCancellable>()
    
    func getUser(id: String) {
        userRepository.getUser(id: id)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                default:
                    break
                }
            } receiveValue: {
                self.userProfile = $0
            }.store(in: &cancellables)
    }
}
