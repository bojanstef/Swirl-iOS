//
//  AuthWireframe.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/9/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

protocol AuthModuleDelegate: class {}

final class AuthWireframe {
    fileprivate weak var moduleDelegate: AuthModuleDelegate?

    init(moduleDelegate: AuthModuleDelegate) {
        self.moduleDelegate = moduleDelegate
    }
}

extension AuthWireframe: ControllerGettable {
    var viewController: UIViewController {
        let dataService: AuthDataServiceable = DataService.defaultService
        let interactor = AuthInteractor(moduleDelegate: moduleDelegate, dataService: dataService)
        let presenter = AuthPresenter(interactor: interactor)
        return AuthViewController(presenter: presenter)
    }
}
