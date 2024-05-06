//
//  MainMenuItem.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 6/5/24.
//

import Foundation

struct MainMenuItem: Identifiable {
    var id: String {
        name
    }
    let name: String
    let image: String
}
