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

final class MainCoordinator {
    fileprivate let tabBarController = UITabBarController()

    fileprivate lazy var createContentController: UINavigationController = self.createController(.createContent)
    fileprivate lazy var curateController: UINavigationController = self.createController(.curate)
    fileprivate lazy var discoverController: UINavigationController = self.createController(.discover)
    fileprivate lazy var followingController: UINavigationController = self.createController(.following)
    fileprivate lazy var profileController: UINavigationController = self.createController(.profile)
}

extension MainCoordinator: Stoppable {
    func start() {
        let controllers = [
            discoverController,
            curateController,
            createContentController,
            followingController,
            profileController
        ]
        tabBarController.setViewControllers(controllers, animated: false)
    }

    func stop() {

    }
}

extension MainCoordinator: CreateContentModuleDelegate {}
extension MainCoordinator: CurateModuleDelegate {}
extension MainCoordinator: DiscoverModuleDelegate {}
extension MainCoordinator: FollowingModuleDelegate {}
extension MainCoordinator: ProfileModuleDelegate {}

fileprivate extension MainCoordinator {
    private func create(_ viewController: UIViewController, image: UIImage?, title: String?) -> UINavigationController {
        viewController.navigationItem.title = title
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: nil)
        return navigationController
    }

    func createController(_ controller: Controller) -> UINavigationController {
        switch controller {
        case .createContent:
            let viewController = CreateContentWireframe(moduleDelegate: self).viewController
            return create(viewController, image: UIImage(asset: .createContent), title: "Create")

        case .curate:
            let viewController = CurateWireframe(moduleDelegate: self).viewController
            return create(viewController, image: UIImage(asset: .curate), title: "Curate")

        case .discover:
            let viewController = DiscoverWireframe(moduleDelegate: self).viewController
            return create(viewController, image: UIImage(asset: .discover), title: "Discover")

        case .following:
            let viewController = FollowingWireframe(moduleDelegate: self).viewController
            return create(viewController, image: UIImage(asset: .following), title: "Following")

        case .profile:
            let viewController = ProfileWireframe(moduleDelegate: self).viewController
            return create(viewController, image: UIImage(asset: .profile), title: "Profile")
        }
    }
}
