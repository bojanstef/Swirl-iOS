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
        print(#function)
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
            return createNoTitle(viewController, image: UIImage(asset: .profile), title: "Profile")
        }
    }
}
