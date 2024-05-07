//
//  User.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 7/5/24.
//

import Foundation

struct User {
    let id: Int
    let name: String
    let phone: String
    let website: String
    
    func calculateUserHash() -> String {
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
