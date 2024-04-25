//
//  ProfileViewModelTests.swift
//  miniPostTests
//
//  Created by Amine Hajri on 25.04.24.
//

import XCTest
import Combine
@testable import miniPost

final class ProfileViewModelTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    private var profileViewModel: ProfileViewModel?
    
    override func setUp() {
        @Provider var userRepository = UserRepositoryMock() as UserRepositoryProtocol
        profileViewModel = ProfileViewModel()
    }
    
    func testGetUsers(){
        profileViewModel?.getUser(id: "1")
        profileViewModel?.$userProfile
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink(receiveValue: { profile in
                XCTAssertEqual(profile, MockedDataSource.users.first(where: {$0.id == 1}))
            }).store(in: &cancellables)
    }
}
