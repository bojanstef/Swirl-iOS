//
//  AuthPresenter.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/9/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import Foundation

protocol AuthPresentable {}

final class AuthPresenter {
    fileprivate let interactor: AuthInteractor

    init(interactor: AuthInteractor) {
        self.interactor = interactor
    }
}

extension AuthPresenter: AuthPresentable {}
