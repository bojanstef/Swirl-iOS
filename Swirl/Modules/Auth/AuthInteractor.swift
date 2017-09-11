//
//  AuthInteractor.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/9/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import Foundation

protocol AuthInteractable {
    func loginSucceeded()
    func requestLogin(with viewController: AuthViewController, completion: @escaping ((Bool, Error?) -> Void))
}

final class AuthInteractor {
    fileprivate weak var moduleDelegate: AuthModuleDelegate?
    fileprivate let dataService: AuthDataServiceable

    init(moduleDelegate: AuthModuleDelegate?, dataService: AuthDataServiceable) {
        self.moduleDelegate = moduleDelegate
        self.dataService = dataService
    }
}

extension AuthInteractor: AuthInteractable {
    func loginSucceeded() {
        moduleDelegate?.loginSucceeded()
    }

    func requestLogin(with viewController: AuthViewController, completion: @escaping ((Bool, Error?) -> Void)) {
        dataService.requestLogin(with: viewController, completion: completion)
    }
}
