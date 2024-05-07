//
//  usersLists.swift
//  miniPost
//
//  Created by Robert Lang on 21/3/24.
//

import UIKit

// TODO: After an initial review of this class, it's easier to migrate it to SwiftUI

class UsersListViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    private var data: [User] = []

    private let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.register(UsersCollectionCell.self, forCellWithReuseIdentifier: UsersCollectionCell.identifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private lazy var loadingView: UIView = {
        let label = UILabel(frame: CGRect(x: 0, y: 200, width: 300, height: 50))
        label.text = "Loading..."
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            view.topAnchor.constraint(equalTo: collectionView.topAnchor),
            view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor)
        ])
        collectionView.delegate = self
        collectionView.dataSource = self

        view.addSubview(loadingView)
        view.addConstraint(loadingView.topAnchor.constraint(equalTo: view.topAnchor))
        
        Task {
            await fetchData()
        }
    }
    
    private func fetchData() async {
        let users = await getUsers()
        
        // Here we have resolved a bug in which if the `fetch` were performed several times,
        // the app would have appended the same information without cleaning the state.
        data = users.map { $0.toDomain }
        
        onDataLoaded()
    }
    
    @MainActor
    private func onDataLoaded() {
        collectionView.reloadData()
        loadingView.isHidden = true
    }

    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: UsersCollectionCell.identifier,
            for: indexPath
        ) as? UsersCollectionCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: data[indexPath.row])
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showUserModal(user: data[indexPath.row])
    }

    private func showUserModal(user: User) {
        view.addSubview(UserView(frame: view.frame, userName: user.name, userPhone: user.phone))
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height: CGFloat = 90
        return CGSize(width: width, height: height)
    }
}

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
