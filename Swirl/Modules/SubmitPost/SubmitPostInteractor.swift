//
//  SubmitPostInteractor.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/21/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import Foundation

protocol SubmitPostInteractable {
    func dismiss()
    func submitPost(_ videoURL: URL, title: String, completion: @escaping ((Error?) -> Void))
}

final class SubmitPostInteractor {
    fileprivate weak var moduleDelegate: SubmitPostModuleDelegate?
    fileprivate let dataService: SubmitPostDataServiceable

    init(moduleDelegate: SubmitPostModuleDelegate?, dataService: SubmitPostDataServiceable) {
        self.moduleDelegate = moduleDelegate
        self.dataService = dataService
    }
}

extension SubmitPostInteractor: SubmitPostInteractable {
    func dismiss() {
        moduleDelegate?.dismiss()
    }

    func submitPost(_ videoURL: URL, title: String, completion: @escaping ((Error?) -> Void)) {
        dataService.submitPost(videoURL, title: title, completion: completion)
    }
}
