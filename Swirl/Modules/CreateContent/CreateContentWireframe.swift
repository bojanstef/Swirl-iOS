//
//  CreateContentWireframe.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/8/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

protocol CreateContentModuleDelegate: class {}

final class CreateContentWireframe {
    fileprivate weak var moduleDelegate: CreateContentModuleDelegate?

    init(moduleDelegate: CreateContentModuleDelegate) {
        self.moduleDelegate = moduleDelegate
    }
}

extension CreateContentWireframe: ControllerGettable {
    var viewController: UIViewController {
        return CreateContentViewController(message: "CreateContent Works!")
    }
}
