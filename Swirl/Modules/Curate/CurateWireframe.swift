//
//  CurateWireframe.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/8/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

protocol CurateModuleDelegate: class {}

final class CurateWireframe {
    fileprivate weak var moduleDelegate: CurateModuleDelegate?

    init(moduleDelegate: CurateModuleDelegate) {
        self.moduleDelegate = moduleDelegate
    }
}

extension CurateWireframe: ControllerGettable {
    var viewController: UIViewController {
        return CurateViewController(message: "Curate Works!")
    }
}
