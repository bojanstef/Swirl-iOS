//
//  SubmitPostWireframe.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/21/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

protocol SubmitPostModuleDelegate: class {}

final class SubmitPostWireframe {
    fileprivate weak var moduleDelegate: SubmitPostModuleDelegate?

    init(moduleDelegate: SubmitPostModuleDelegate?) {
        self.moduleDelegate = moduleDelegate
    }
}

extension SubmitPostWireframe: ControllerGettable {
    var viewController: UIViewController {
        let dataService: SubmitPostDataServiceable = dataService.defaultService
        let interactor = SubmitPostInteractor(moduleDelegate: moduleDelegate, dataService: dataService)
        let presenter = SubmitPostPresenter(interactor: interactor)
        return SubmitPostViewController(presenter: presenter)
    }
}
