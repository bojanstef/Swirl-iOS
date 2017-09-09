//
//  RootCoordinator.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/8/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

private enum Controller {
    case create, curate, discover, following, profile
}

final class RootCoordinator {
    fileprivate let window: UIWindow
    fileprivate let tabBarController = UITabBarController()

    fileprivate lazy var discoverController: UINavigationController = self.create(.discover)

    init(window: UIWindow) {
        self.window = window
    }
}

extension RootCoordinator: Starting {
    func start() {
        let controllers = [discoverController]
        tabBarController.setViewControllers(controllers, animated: false)

        window.makeKeyAndVisible()
        window.rootViewController = tabBarController
    }
}

extension RootCoordinator: DiscoverModuleDelegate {}

fileprivate extension RootCoordinator {
    private func create(_ viewController: UIViewController, image: UIImage?, title: String?) -> UINavigationController {
        viewController.navigationItem.title = title
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: nil)
        return navigationController
    }

    func create(_ controller: Controller) -> UINavigationController {
        switch controller {
        case .discover:
            let viewController = DiscoverWireframe(moduleDelegate: self).viewController
            return create(viewController, image: UIImage(asset: .discover), title: "Discover")

        default:
            return UINavigationController()
        }
    }
}
