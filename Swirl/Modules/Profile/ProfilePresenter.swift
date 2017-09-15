//
//  ProfilePresenter.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/11/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import Foundation

protocol ProfilePresentable {
    func getCurrentUser(completion: @escaping ((SwirlUser?, Error?) -> Void))
    func observePosts(for swirlUser: SwirlUser, completion: @escaping (([Post], Error?) -> Void))
    func openSettings()
}

final class ProfilePresenter {
    fileprivate let interactor: ProfileInteractable

    init(interactor: ProfileInteractable) {
        self.interactor = interactor
    }
}

extension ProfilePresenter: ProfilePresentable {
    func getCurrentUser(completion: @escaping ((SwirlUser?, Error?) -> Void)) {
        interactor.getCurrentUser(completion: completion)
    }

    func observePosts(for swirlUser: SwirlUser, completion: @escaping (([Post], Error?) -> Void)) {
        interactor.observePosts(for: swirlUser, completion: completion)
    }

    func openSettings() {
        interactor.openSettings()
    }
}
