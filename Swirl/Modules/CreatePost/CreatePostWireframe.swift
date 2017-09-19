//
//  CreatePostWireframe.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/8/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

protocol CreatePostModuleDelegate: class {
    func dismiss()
}

final class CreatePostWireframe {
    fileprivate weak var moduleDelegate: CreatePostModuleDelegate?

    init(moduleDelegate: CreatePostModuleDelegate) {
        self.moduleDelegate = moduleDelegate
    }
}

extension CreatePostWireframe: ControllerGettable {
    var viewController: UIViewController {
        let dataService: CreatePostDataServiceable = DataService.defaultService
        let cameraService = CameraService.defaultService
        let interactor = CreatePostInteractor(moduleDelegate: moduleDelegate,
                                                 dataService: dataService,
                                                 cameraService: cameraService)
        let presenter = CreatePostPresenter(interactor: interactor)
        return CreatePostViewController(presenter: presenter)
    }
}
