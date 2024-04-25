//
//  UsersListViewController.swift
//  miniPost
//
//  Created by Robert Lang on 21/3/24.
//

import UIKit
import Combine

class UsersListViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    private let usersViewModel = UsersViewModel()
    private var cancellables = Set<AnyCancellable>()
    private var users = [User]()
    private var loader = UIView()
    
    private let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.frame = view.frame
        collectionView.delegate = self
        collectionView.dataSource = self
        
        loader = loadingView()
        view.addSubview(loader)
        
        subscribe()
        usersViewModel.getUsers()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .lightGray
        let label = UILabel(frame: cell.contentView.bounds)
        label.text = users[indexPath.item].name
        label.textAlignment = .center
        cell.contentView.addSubview(label)
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        return cell
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        let row = self.collectionView.indexPathForItem(at: sender.location(in: self.collectionView))!.row
        showUser(row)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height: CGFloat = 90
        return CGSize(width: width, height: height)
    }
    
    func loadingView() -> UIView {
        let view = UIView(frame: view.frame)
        
        let label = UILabel(frame: CGRect(x: 0, y: 200, width: 300, height: 50))
        label.text = "Loading..."
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        view.addConstraint(label.topAnchor.constraint(equalTo: view.topAnchor))
        
        return view
    }
    
    func showUser(_ row: Int) {
        let user = users[row]
        showUserModal(user: user)
    }
    
    func showUserModal(user: User) {
        view.addSubview(UserView(frame: view.frame, userName: user.name, userPhone: user.phone))
    }
    
    private func subscribe() {
        usersViewModel.$users
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                default:
                    break
                }
            } receiveValue: { [self] in
                loader.isHidden = true
                users = $0
                collectionView.reloadData()
            }.store(in: &cancellables)
    }
}
