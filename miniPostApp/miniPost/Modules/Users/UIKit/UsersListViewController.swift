//
//  usersLists.swift
//  miniPost
//
//  Created by Robert Lang on 21/3/24.
//

import UIKit

// TODO: After an initial review of this class, is easier to migrate it to SwiftUI

class UsersListViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    struct UserDisplay {
        let id: Int
        let name: String
    }

    private var data: [UserDisplay] = []

    private let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
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
        data = users.map { UserDisplay(id: $0.id, name: $0.name) }
        
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
        // Performance issue.
        // The app is creating a new label every time it dequeues a cell, and puts this new label on top of the new one from the previous time (reuse).
        // TODO: Create a subclass of UICollectionViewCell that has just a single text view in it.
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .lightGray
        let label = UILabel(frame: cell.contentView.bounds)
        label.text = data[indexPath.item].name
        label.textAlignment = .center
        cell.contentView.addSubview(label)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showUser(indexPath.row)
    }
    
    private func showUser(_ row: Int) {
        let user = data[row]
        Task {
            let user2 = await getUser(id: String(user.id))
            
            await MainActor.run {
                showUserModal(user: user2)
            }
        }
    }

    private func showUserModal(user: UserDTO) {
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
