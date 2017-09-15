//
//  MainCoordinator.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/9/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

private enum Controller {
    case createContent, curate, discover, following, profile
}

private struct Constants {
    static let createTitle = "Create"
    static let curateTitle = "Curate"
    static let discoverTitle = "Discover"
    static let followingTitle = "Following"
    static let profileTitle = "Profile"
}

final class MainCoordinator {
    fileprivate let navigationController: UINavigationController
    fileprivate lazy var createContentController: UINavigationController = self.createController(.createContent)
    fileprivate lazy var curateController: UINavigationController = self.createController(.curate)
    fileprivate lazy var discoverController: UINavigationController = self.createController(.discover)
    fileprivate lazy var followingController: UINavigationController = self.createController(.following)
    fileprivate lazy var profileController: UINavigationController = self.createController(.profile)

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension MainCoordinator: Stoppable {
    func start() {
        let controllers = [discoverController, createContentController, followingController, profileController]
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers(controllers, animated: false)
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.pushViewController(tabBarController, animated: false)
    }

    func stop() {
        navigationController.popViewController(animated: true)
    }
}

extension MainCoordinator: CreateContentModuleDelegate {}
extension MainCoordinator: CurateModuleDelegate {}
extension MainCoordinator: DiscoverModuleDelegate {}
extension MainCoordinator: FollowingModuleDelegate {}

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
        case .createContent:
            let viewController = CreateContentWireframe(moduleDelegate: self).viewController
            let image = UIImage(asset: .createContent)
            return create(viewController, image: image, title: Constants.createTitle)

        case .curate:
            let viewController = CurateWireframe(moduleDelegate: self).viewController
            let image = UIImage(asset: .curate)
            return create(viewController, image: image, title: Constants.curateTitle)

        case .discover:
            let viewController = DiscoverWireframe(moduleDelegate: self).viewController
            let image = UIImage(asset: .discover)
            return create(viewController, image: image, title: Constants.discoverTitle)

        case .following:
            let viewController = FollowingWireframe(moduleDelegate: self).viewController
            let image = UIImage(asset: .following)
            return create(viewController, image: image, title: Constants.followingTitle)

        case .profile:
            let viewController = ProfileWireframe(moduleDelegate: self).viewController
            let image = UIImage(asset: .profile)
            return createNoTitle(viewController, image: image, title: Constants.profileTitle)
        }
    }
}
