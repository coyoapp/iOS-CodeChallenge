//
//  MockedDataSource.swift
//  miniPostTests
//
//  Created by Amine Hajri on 25.04.24.
//

import Foundation
@testable import miniPost

struct MockedDataSource {
    static let users = [
        User(id: 0, name: "John", phone: "123", website: "john@john"),
        User(id: 1, name: "Tim", phone: "456", website: "tim@tim"),
        User(id: 2, name: "Peter", phone: "789", website: "peter@peter")
    ]
    
    static let apiPosts = [
        APIPost(id: 0, title: "Sports", body: "Tomorrow games", userId: 0),
        APIPost(id: 1, title: "Culture", body: "Books", userId: 1),
        APIPost(id: 2, title: "Work", body: "Meetings", userId: 2)
    ]
    
    static let posts = [
        Post(id: apiPosts[0].id, authorName: users[0].name, title: apiPosts[0].title, body: apiPosts[0].body),
        Post(id: apiPosts[1].id, authorName: users[1].name, title: apiPosts[1].title, body: apiPosts[1].body),
        Post(id: apiPosts[2].id, authorName: users[2].name, title: apiPosts[2].title, body: apiPosts[2].body)
    ]
}
