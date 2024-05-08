//
//  ProfileViewModel.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 7/5/24.
//

import Foundation
import SwiftUI

@Observable
class ProfileViewModel {
    struct UserDisplay {
        let name: String
        let phone: String
        let website: String
        let userHash: String
        
        static let any: UserDisplay = .init(name: "", phone: "", website: "", userHash: "")
    }
    
    var state: ViewModelState<UserDisplay> = .idle
    
    private let getProfileUseCase: GetProfileInformationUseCase
    
    init(getProfileUseCase: GetProfileInformationUseCase) {
        self.getProfileUseCase = getProfileUseCase
    }
    
    func fetchInfo() async {
        withAnimation {
            state = .loading
        }
        
        do {
            let userId = "4"
            let user = try await getProfileUseCase(userId: userId)
            let userDisplay: UserDisplay = .init(
                name: user.name,
                phone: user.phone,
                website: user.website,
                userHash: user.calculateUserHash()
            )
            
            await MainActor.run {
                withAnimation {
                    state = .loaded(userDisplay)
                }
            }
        } catch {
            await MainActor.run {
                withAnimation {
                    state = .failed(error)
                }
            }
        }
    }
}
