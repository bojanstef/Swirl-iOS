//
//  ProfileViewController.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/8/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import IGListKit

final class ProfileViewController: UIViewController {
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    fileprivate let presenter: ProfilePresentable
    fileprivate var profile = Profile()
    fileprivate lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 1)
    }()

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    init(presenter: ProfilePresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCollectionView()
        setupNavBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCurrentUser()
    }
}

extension ProfileViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [profile]
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return ProfileSectionController(delegate: self)
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}

extension ProfileViewController: ProfileSocialsViewDelegate {
    func postsButtonPressed() {
        print(#file, #function)
    }

    func followersButtonPressed() {
        print(#file, #function)
    }

    func followingButtonPressed() {
        print(#file, #function)
    }
}

fileprivate extension ProfileViewController {
    dynamic func settingsButtonPressed() {
        presenter.openSettings()
    }

    func setupNavBar() {
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(asset: .settings), style: .plain,
                                                 target: self, action: .settingsButtonPressed)
        rightBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    func setupCollectionView() {
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }

    func loadCurrentUser() {
        presenter.getCurrentUser { [weak self] swirlUser, error in
            if let error = error {
                print(error); return
            } else {
                guard let swirlUser = swirlUser else { return }
                self?.updateUser(swirlUser)
                self?.loadPosts(for: swirlUser)
            }
        }
    }

    func updateUser(_ swirlUser: SwirlUser) {
        profile = profile.update(swirlUser)
        navigationItem.title = swirlUser.username
        adapter.performUpdates(animated: true)
    }

    func loadPosts(for swirlUser: SwirlUser) {
        presenter.observePosts(for: swirlUser) { [weak self] posts, error in
            if let error = error {
                print(error); return
            } else {
                self?.updatePosts(with: posts)
            }
        }
    }

    func updatePosts(with posts: [Post]) {
        profile = profile.update(posts: posts)
        adapter.performUpdates(animated: true)
    }
}

fileprivate extension Selector {
    static let settingsButtonPressed = #selector(ProfileViewController.settingsButtonPressed)
}
