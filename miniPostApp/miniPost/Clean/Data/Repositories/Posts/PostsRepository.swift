//
//  PostsRepository.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 6/5/24.
//

import Foundation

protocol PostsRepository {
    func getAllPosts() async throws -> [Post]
}

struct PostsRepositoryImplementation: PostsRepository {
    private let postsDataSource: PostsDataSource
    private let usersDataSource: UsersDataSource
    
    init(postsDataSource: PostsDataSource, usersDataSource: UsersDataSource) {
        self.postsDataSource = postsDataSource
        self.usersDataSource = usersDataSource
    }
    
    func getAllPosts() async throws -> [Post] {
        guard let postsDTO = try? await postsDataSource.getPosts() else { return [] }
        
        let usersDictionary = try await withThrowingTaskGroup(
            of: (Int, UserDTO)?.self,
            returning: [Int: UserDTO].self
        ) { group in
            for dto in postsDTO {
                group.addTask {
                    do {
                        let userDTO = try await usersDataSource.getUser(id: String(dto.userId))
                        return (dto.userId, userDTO)
                    } catch {
                        return nil
                    }
                }
            }
            
            return try await group
                .compactMap { $0 }
                .reduce(into: [:]) { partialResult, taskResult in
                    partialResult[taskResult.0] = taskResult.1
                }
        }
        
        return postsDTO.compactMap {
            guard let userDTO = usersDictionary[$0.userId] else { return nil }
            return $0.toDomain(author: userDTO.name)
        }
    }
}
