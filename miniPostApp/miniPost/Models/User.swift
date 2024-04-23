//
//  User.swift
//  miniPost
//
//  Created by Triet Le on 23.4.2024.
//

import Foundation

// MARK: - User
struct User: Codable, Hashable {
    let id: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
}

extension User {
    func userHash() -> String {
        let nameComponents = name.components(separatedBy: " ")
        var nameAbbreviation = ""
        for component in nameComponents {
            let firstTwoChars = component.prefix(2)
            nameAbbreviation.append(contentsOf: firstTwoChars)
        }

        let phoneDigits = phone.components(separatedBy: "-")
        var phoneSum = 0
        for digit in phoneDigits {
            if let intValue = Int(digit) {
                phoneSum += intValue
            }
        }

        let websiteComponents = website.components(separatedBy: ".")
        let domainName = websiteComponents.first ?? ""

        let finalString = nameAbbreviation + String(phoneSum) + domainName
        return finalString
    }
}

// MARK: - Address
struct Address: Codable, Hashable {
    let street, suite, city, zipcode: String

    var formattedAddress: String {
        "\(street) \(suite), \(zipcode), \(city)"
    }
}

// MARK: - Company
struct Company: Codable, Hashable {
    let name, catchPhrase, bs: String
}

typealias Users = [User]
