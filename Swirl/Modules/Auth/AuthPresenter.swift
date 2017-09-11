//
//  AuthPresenter.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/9/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

protocol AuthPresentable {
    var titleView: UIImageView { get }
}

final class AuthPresenter {
    fileprivate let interactor: AuthInteractable

    init(interactor: AuthInteractable) {
        self.interactor = interactor
    }
}

extension AuthPresenter: AuthPresentable {
    var titleView: UIImageView {
        let logo = UIImage(asset: .logo)
        return UIImageView(image: logo)
    }
}
