//
//  ProfileInteractor.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/11/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import Foundation

protocol ProfileInteractable {
    func getCurrentUser(completion: @escaping ((SwirlUser?, Error?) -> Void))
    func observePosts(for swirlUser: SwirlUser, completion: @escaping (([Post], Error?) -> Void))
    func openSettings()
}

final class ProfileInteractor {
    fileprivate weak var moduleDelegate: ProfileModuleDelegate?
    fileprivate let dataService: ProfileDataServiceable

    init(moduleDelegate: ProfileModuleDelegate?, dataService: ProfileDataServiceable) {
        self.moduleDelegate = moduleDelegate
        self.dataService = dataService
    }
}

extension ProfileInteractor: ProfileInteractable {
    func getCurrentUser(completion: @escaping ((SwirlUser?, Error?) -> Void)) {
        dataService.getCurrentUser(completion: completion)
    }

    func observePosts(for swirlUser: SwirlUser, completion: @escaping (([Post], Error?) -> Void)) {
        dataService.observePosts(for: swirlUser, completion: completion)
    }

    func openSettings() {
        moduleDelegate?.openSettings()
    }
}
