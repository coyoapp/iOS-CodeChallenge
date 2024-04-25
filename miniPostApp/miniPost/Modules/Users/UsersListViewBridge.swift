//
//  UsersListViewBridge.swift
//  miniPost
//
//  Created by Robert Lang on 21/3/24.
//

import SwiftUI
import UIKit

struct UsersListViewBridge: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        return UsersListViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}



