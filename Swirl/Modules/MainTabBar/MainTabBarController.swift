//
//  MainTabBarController.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/18/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

final class MainTabBarController: UITabBarController {
    fileprivate let presenter: MainTabBarPresentable

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    init(presenter: MainTabBarPresentable, viewControllers: [UIViewController]) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.setViewControllers(viewControllers, animated: false)
        self.delegate = self
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          shouldSelect viewController: UIViewController) -> Bool {

        guard viewController.childViewControllers.contains(where: { viewController in
            viewController is CreatePostDummyViewController
        }) else {
            return true
        }

        presenter.showCreateContent()
        return false
    }
}
