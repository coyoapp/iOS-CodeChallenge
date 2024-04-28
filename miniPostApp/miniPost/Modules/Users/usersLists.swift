//
//  usersLists.swift
//  miniPost
//
//  Created by Robert Lang on 21/3/24.
//

import UIKit

class UsersListViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    struct viewUser {
        let id: Int
        let name: String
    }

    var data: [viewUser] = []

    let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return cv
    }()

    var onDataLoaded: (()->Void)?

    func setOnDataLoaded(onDataLoadedHandler: @escaping ()->Void) {
        onDataLoaded = onDataLoadedHandler
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        collectionView.frame = view.frame
        collectionView.delegate = self
        collectionView.dataSource = self
        fetchData()

        let loadingView = loadingView()
        view.addSubview(loadingView)

        self.onDataLoaded = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                loadingView.isHidden = true
            }
        }
    }

    func mapUsers(users: [User]) {
        for (_, user) in users.enumerated() {
            let viewUser = viewUser(id: user.id, name: user.name)
            data.append(viewUser)
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        onDataLoaded!()
    }

    func fetchData() {
        getUsers(callback: mapUsers)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .lightGray
        let label = UILabel(frame: cell.contentView.bounds)
        label.text = data[indexPath.item].name
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
        let user = data[row]
        Task {
            let user2 = await getUser(id: String(user.id))
            showUserModal(user: user2)
        }
    }

    func showUserModal(user: User) {
        view.addSubview(userView(frame: view.frame, userName: user.name, userPhone: user.phone))
    }

    
}

class userView: UIView {

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
