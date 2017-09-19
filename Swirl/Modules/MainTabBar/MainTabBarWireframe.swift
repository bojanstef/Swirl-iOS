//
//  MainTabBarWireframe.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/18/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

protocol MainTabBarModuleDelegate: class {
    func showCreateContent()
}

final class MainTabBarWireframe {
    fileprivate weak var moduleDelegate: MainTabBarModuleDelegate?
    fileprivate let viewControllers: [UIViewController]

    init(moduleDelegate: MainTabBarModuleDelegate, viewControllers: [UIViewController]) {
        self.moduleDelegate = moduleDelegate
        self.viewControllers = viewControllers
    }
}

extension MainTabBarWireframe: ControllerGettable {
    var tabBarController: UIViewController {
        let dataService: MainTabBarDataServiceable = DataService.defaultService
        let interactor = MainTabBarInteractor(moduleDelegate: moduleDelegate, dataService: dataService)
        let presenter = MainTabBarPresenter(interactor: interactor)
        return MainTabBarController(presenter: presenter, viewControllers: viewControllers)
    }
}
