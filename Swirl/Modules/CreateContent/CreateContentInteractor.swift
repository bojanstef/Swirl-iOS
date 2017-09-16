//
//  CreateContentInteractor.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/15/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import Foundation

protocol CreateContentInteractable {}

final class CreateContentInteractor {
    fileprivate weak var moduleDelegate: CreateContentModuleDelegate?
    fileprivate let dataService: CreateContentDataServiceable

    init(moduleDelegate: CreateContentModuleDelegate?, dataService: CreateContentDataServiceable) {
        self.moduleDelegate = moduleDelegate
        self.dataService = dataService
    }
}

extension CreateContentInteractor: CreateContentInteractable {}
