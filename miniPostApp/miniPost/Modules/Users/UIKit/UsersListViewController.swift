//
//  usersLists.swift
//  miniPost
//
//  Created by Robert Lang on 21/3/24.
//

import UIKit

protocol UIUsersListView: AnyObject {
    func didLoadData()
}

class UsersListViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
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
    
    private let configurator: UsersConfigurator = .init()
    var presenter: UsersPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(viewController: self)

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
            await presenter?.viewDidLoad()
        }
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
        return presenter?.users.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let presenter,
              indexPath.row < presenter.users.count,
              let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: UsersCollectionCell.identifier,
                for: indexPath
              ) as? UsersCollectionCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: presenter.users[indexPath.row])
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let presenter, indexPath.row < presenter.users.count else { return }
        
        showUserModal(user: presenter.users[indexPath.row])
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

extension UsersListViewController: UIUsersListView {
    func didLoadData() {
        onDataLoaded()
    }
}
