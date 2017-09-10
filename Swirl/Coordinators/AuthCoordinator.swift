//
//  AuthCoordinator.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/8/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

final class AuthCoordinator {
    fileprivate let window: UIWindow
    fileprivate let authService: AuthDataServiceable
    fileprivate let navigationController = UINavigationController()
    fileprivate var mainCoordinator: Stoppable?

    init(window: UIWindow, authService: AuthDataServiceable) {
        self.window = window
        self.authService = authService
    }
}

extension AuthCoordinator: Starting {
    func start() {
        window.rootViewController = getRootController()
        window.makeKeyAndVisible()
        if authService.isAuthenticated {
            navigateToMainCoordinator()
        }
    }
}

extension AuthCoordinator: AuthModuleDelegate {
    // if log in is successful { navigateToMainCoordinator() }
}

fileprivate extension AuthCoordinator {
    func getRootController() -> UINavigationController {
        let viewController = AuthWireframe(moduleDelegate: self).viewController
        navigationController.pushViewController(viewController, animated: false)
        return navigationController
    }

    func navigateToMainCoordinator() {
        mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator?.start()
    }
}
