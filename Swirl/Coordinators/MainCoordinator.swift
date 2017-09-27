//
//  MainCoordinator.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/9/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

private enum Controller {
    case createPost, createPostDummy, curate, discover, following, profile
}

private struct Constants {
    static let createPostTitle = "Create"
    static let curateTitle = "Curate"
    static let discoverTitle = "Discover"
    static let followingTitle = "Following"
    static let profileTitle = "Profile"
}

final class MainCoordinator {
    fileprivate lazy var createPostDummyController: UINavigationController = self.createController(.createPostDummy)
    fileprivate lazy var curateController: UINavigationController = self.createController(.curate)
    fileprivate lazy var discoverController: UINavigationController = self.createController(.discover)
    fileprivate lazy var followingController: UINavigationController = self.createController(.following)
    fileprivate lazy var profileController: UINavigationController = self.createController(.profile)
    fileprivate let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

/**** Common Methods ****/
extension MainCoordinator {
    func dismiss() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}

extension MainCoordinator: Stoppable {
    func start() {
        let viewControllers: [UIViewController] = [
            discoverController, curateController, createPostDummyController, followingController, profileController
        ]

        let mainTabBarWireframe = MainTabBarWireframe(moduleDelegate: self, viewControllers: viewControllers)
        let tabBarController = mainTabBarWireframe.tabBarController
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.pushViewController(tabBarController, animated: false)
    }

    func stop() {
        navigationController.popViewController(animated: true)
    }
}

extension MainCoordinator: MainTabBarModuleDelegate {
    func showCreateContent() {
        let viewController = CreatePostWireframe(moduleDelegate: self).viewController
        let createPostNavigationController = UINavigationController(rootViewController: viewController)
        navigationController.present(createPostNavigationController, animated: true, completion: nil)
    }
}

extension MainCoordinator: CreatePostModuleDelegate {
    func navigateToSubmitPost(from navigationController: UINavigationController, with videoURL: URL) {
        let viewController = SubmitPostWireframe(moduleDelegate: self, videoURL: videoURL).viewController
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension MainCoordinator: CurateModuleDelegate {}
extension MainCoordinator: DiscoverModuleDelegate {}
extension MainCoordinator: FollowingModuleDelegate {}
extension MainCoordinator: SubmitPostModuleDelegate {}

extension MainCoordinator: ProfileModuleDelegate {
    func openSettings() {
        print(#file, #function)
    }
}

fileprivate extension MainCoordinator {
    private func create(_ viewController: UIViewController, image: UIImage?, title: String?) -> UINavigationController {
        viewController.navigationItem.title = title
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: nil)
        return navigationController
    }

    private func createNoTitle(_ viewController: UIViewController,
                               image: UIImage?, title: String?) -> UINavigationController {

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: nil)
        return navigationController
    }

    func createController(_ controller: Controller) -> UINavigationController {
        switch controller {
        case .createPost:
            let viewController = CreatePostWireframe(moduleDelegate: self).viewController
            return create(viewController, image: UIImage(asset: .createPost), title: Constants.createPostTitle)

        case .createPostDummy:
            let viewController = CreatePostDummyViewController()
            return create(viewController, image: UIImage(asset: .createPost), title: Constants.createPostTitle)

        case .curate:
            let viewController = CurateWireframe(moduleDelegate: self).viewController
            return create(viewController, image: UIImage(asset: .curate), title: Constants.curateTitle)

        case .discover:
            let viewController = DiscoverWireframe(moduleDelegate: self).viewController
            return create(viewController, image: UIImage(asset: .discover), title: Constants.discoverTitle)

        case .following:
            let viewController = FollowingWireframe(moduleDelegate: self).viewController
            return create(viewController, image: UIImage(asset: .following), title: Constants.followingTitle)

        case .profile:
            let viewController = ProfileWireframe(moduleDelegate: self).viewController
            return createNoTitle(viewController, image: UIImage(asset: .profile), title: Constants.profileTitle)
        }
    }
}
