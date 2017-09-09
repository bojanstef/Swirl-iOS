//
//  FollowingWireframe.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/8/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

protocol FollowingModuleDelegate: class {}

final class FollowingWireframe {
    fileprivate weak var moduleDelegate: FollowingModuleDelegate?

    init(moduleDelegate: FollowingModuleDelegate) {
        self.moduleDelegate = moduleDelegate
    }
}

extension FollowingWireframe: ControllerGettable {
    var viewController: UIViewController {
        return FollowingViewController(message: "Following Works!")
    }
}
