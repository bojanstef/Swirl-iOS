//
//  RootCoordinator.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/8/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

final class RootCoordinator {
    fileprivate let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }
}

extension RootCoordinator: Starting {
    func start() {
        window.makeKeyAndVisible()
        window.rootViewController = TestViewController(message: "It Works!")
    }
}
