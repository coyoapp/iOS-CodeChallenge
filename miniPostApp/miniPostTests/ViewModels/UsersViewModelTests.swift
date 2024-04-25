//
//  UsersViewModelTests.swift
//  miniPostTests
//
//  Created by Amine Hajri on 25.04.24.
//

import XCTest
import Combine
@testable import miniPost

final class UsersViewModelTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    private var usersViewModels: UsersViewModel?
    
    override func setUp() {
        @Provider var userRepository = UserRepositoryMock() as UserRepositoryProtocol
        usersViewModels = UsersViewModel()
    }
    
    func testGetUsers(){
        usersViewModels?.getUsers()
        usersViewModels?.$users
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink(receiveValue: { users in
                XCTAssertEqual(users, MockedDataSource.users)
            }).store(in: &cancellables)
    }
}
