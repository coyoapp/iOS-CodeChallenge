//
//  UserView.swift
//  miniPost
//
//  Created by Amine Hajri on 25.04.24.
//

import Foundation
import UIKit

class UserView: UIView {
    
    init(frame: CGRect, userName: String, userPhone: String) {
        
        super.init(frame: frame)
        self.backgroundColor = .white
        
        let userNameLabel = UILabel()
        userNameLabel.text = userName
        self.addSubview(userNameLabel)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            userNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -20)
        ])
        
        
        let userPhoneLabel = UILabel()
        userPhoneLabel.text = userPhone
        self.addSubview(userPhoneLabel)
        userPhoneLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userPhoneLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            userPhoneLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        
        
        let closeButton = UIButton(type: .custom)
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.blue, for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        self.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            closeButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 20)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func closeButtonTapped() {
        self.removeFromSuperview()
    }
}
