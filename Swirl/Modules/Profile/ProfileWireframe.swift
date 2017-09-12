//
//  ProfileWireframe.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/8/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

protocol ProfileModuleDelegate: class {}

final class ProfileWireframe {
    fileprivate weak var moduleDelegate: ProfileModuleDelegate?

    init(moduleDelegate: ProfileModuleDelegate) {
        self.moduleDelegate = moduleDelegate
    }
}

extension ProfileWireframe: ControllerGettable {
    var viewController: UIViewController {
        let dataService: ProfileDataServiceable = DataService.defaultService
        let interactor = ProfileInteractor(moduleDelegate: moduleDelegate, dataService: dataService)
        let presenter = ProfilePresenter(interactor: interactor)
        return ProfileViewController(presenter: presenter)
    }
}
