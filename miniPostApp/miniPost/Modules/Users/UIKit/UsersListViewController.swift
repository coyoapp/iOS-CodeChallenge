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

class UsersListViewController: UIViewController {
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
}

extension UsersListViewController: UIUsersListView {
    func didLoadData() {
        onDataLoaded()
    }
    
    @MainActor
    private func onDataLoaded() {
        collectionView.reloadData()
        loadingView.isHidden = true
    }
}

extension UsersListViewController: UICollectionViewDataSource {
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
}

extension UsersListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let presenter, indexPath.row < presenter.users.count else { return }
        
        showUserModal(user: presenter.users[indexPath.row])
    }
    
    private func showUserModal(user: User) {
        view.addSubview(UserView(frame: view.frame, userName: user.name, userPhone: user.phone))
    }
}

extension UsersListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height: CGFloat = 90
        return CGSize(width: width, height: height)
    }
}
