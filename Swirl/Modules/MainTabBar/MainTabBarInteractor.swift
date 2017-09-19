//
//  MainTabBarInteractor.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/18/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import Foundation

protocol MainTabBarInteractable {
    func showCreateContent()
}

final class MainTabBarInteractor {
    fileprivate weak var moduleDelegate: MainTabBarModuleDelegate?
    fileprivate let dataService: MainTabBarDataServiceable

    init(moduleDelegate: MainTabBarModuleDelegate?, dataService: MainTabBarDataServiceable) {
        self.moduleDelegate = moduleDelegate
        self.dataService = dataService
    }
}

extension MainTabBarInteractor: MainTabBarInteractable {
    func showCreateContent() {
        moduleDelegate?.showCreateContent()
    }
}
