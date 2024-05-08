//
//  PostDisplay.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 8/5/24.
//

import Foundation

struct PostDisplay: Identifiable, Equatable {
    let id: Int
    let authorName: String
    let title: String
    let body: String
}
