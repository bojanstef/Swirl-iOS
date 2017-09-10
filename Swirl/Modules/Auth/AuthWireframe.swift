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
        return AuthViewController(message: "Auth Works!")
    }
}
