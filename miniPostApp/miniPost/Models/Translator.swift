//
//  Translator.swift
//  miniPost
//
//  Created by Dmitry Suvorov on 29.4.2024.
//

import Foundation

final class Translator {
    static func userFromRemote(_ remote: UserRemote) -> User {
        User(
            id: remote.id,
            name: remote.name,
            phone: remote.phone,
            website: remote.website,
            hash: Translator.calculateUserHash(
                name: remote.name,
                phone: remote.phone,
                website: remote.website
            )
        )
    }

    static func postFromRemote(_ remote: PostRemote, authorName: String) -> Post {
        Post(
            id: remote.id,
            authorName: authorName,
            title: remote.title,
            body: remote.body
        )
    }

    static func calculateUserHash(name: String, phone: String, website: String) -> String {
        let nameAbbreviation = name.components(separatedBy: " ")
            .map { $0.prefix(2) }
            .joined()

        let phoneSum = phone.components(separatedBy: "-")
            .compactMap(Int.init)
            .reduce(0, +)

        let domainName = website.components(separatedBy: ".")
            .first ?? ""

        return nameAbbreviation + String(phoneSum) + domainName
    }
}
