//
//  GetAllPostsUseCaseMock.swift
//  miniPostTests
//
//  Created by Víctor Barrios Sánchez on 7/5/24.
//

@testable import miniPost
import Foundation

class GetAllPostsUseCaseMock: GetAllPostsUseCase {
    var returnValue: [Post] = []
    var callAsFunctionCallsCount = 0
    
    func callAsFunction() async -> [Post] {
        callAsFunctionCallsCount += 1
        return returnValue
    }
}
