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
        return ProfileViewController(message: "Profile Works!")
    }
}
