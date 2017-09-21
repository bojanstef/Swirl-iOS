//
//  SubmitPostInteractor.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/21/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import Foundation

protocol SubmitPostInteractable {}

final class SubmitPostInteractor {
    fileprivate weak var moduleDelegate: SubmitPostModuleDelegate?
    fileprivate let dataService: SubmitPostDataServiceable

    init(moduleDelegate: SubmitPostModuleDelegate?, dataService: SubmitPostDataServiceable) {
        self.moduleDelegate = moduleDelegate
        self.dataService = dataService
    }
}

extension SubmitPostInteractor: SubmitPostInteractable {}
