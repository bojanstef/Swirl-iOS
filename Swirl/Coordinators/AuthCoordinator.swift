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
    fileprivate let authService: AuthServicable
    fileprivate var mainCoordinator: Stoppable?
    fileprivate var navigationController: UINavigationController?

    init(window: UIWindow, authService: AuthServicable) {
        self.window = window
        self.authService = authService
    }
}

extension AuthCoordinator: Starting {
    func start() {
        window.makeKeyAndVisible()
        window.rootViewController = getRootController()

        if authService.isAuthenticated { navigateToMainCoordinator() }
    }
}

extension AuthCoordinator: AuthModuleDelegate {
    // if log in is successful { navigateToMainCoordinator() }
}

fileprivate extension AuthCoordinator {
    func getRootController() -> UINavigationController? {
        let viewController = AuthWireframe(moduleDelegate: self).viewController
        navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }

    func navigateToMainCoordinator() {}
}
