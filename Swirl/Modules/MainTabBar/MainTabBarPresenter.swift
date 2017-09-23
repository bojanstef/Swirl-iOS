//
//  MainTabBarPresenter.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/18/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import Foundation

protocol MainTabBarPresentable {
    func showCreateContent()
}

final class MainTabBarPresenter {
    fileprivate let interactor: MainTabBarInteractable

    init(interactor: MainTabBarInteractable) {
        self.interactor = interactor
    }
}

extension MainTabBarPresenter: MainTabBarPresentable {
    func showCreateContent() {
        interactor.showCreateContent()
    }
}
