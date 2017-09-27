//
//  SubmitPostWireframe.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/21/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

protocol SubmitPostModuleDelegate: class {
    func dismiss()
}

final class SubmitPostWireframe {
    fileprivate weak var moduleDelegate: SubmitPostModuleDelegate?
    fileprivate let videoURL: URL

    init(moduleDelegate: SubmitPostModuleDelegate?, videoURL: URL) {
        self.moduleDelegate = moduleDelegate
        self.videoURL = videoURL
    }
}

extension SubmitPostWireframe: ControllerGettable {
    var viewController: UIViewController {
        let dataService: SubmitPostDataServiceable = DataService.defaultService
        let interactor = SubmitPostInteractor(moduleDelegate: moduleDelegate, dataService: dataService)
        let presenter = SubmitPostPresenter(interactor: interactor)
        return SubmitPostViewController(presenter: presenter, videoURL: videoURL)
    }
}
