//
//  AuthPresenter.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/9/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

protocol AuthPresentable {
    func loginSucceeded()
    func requestLogin(with viewController: AuthViewController, completion: @escaping ((Bool, Error?) -> Void))
}

final class AuthPresenter {
    fileprivate let interactor: AuthInteractable

    init(interactor: AuthInteractable) {
        self.interactor = interactor
    }
}

extension AuthPresenter: AuthPresentable {
    func loginSucceeded() {
        interactor.loginSucceeded()
    }

    func requestLogin(with viewController: AuthViewController, completion: @escaping ((Bool, Error?) -> Void)) {
        interactor.requestLogin(with: viewController, completion: completion)
    }
}
