//
//  SubmitPostPresenter.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/21/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import Foundation

protocol SubmitPostPresentable {
    func dismiss()
    func submitPost(_ videoURL: URL, title: String, completion: @escaping ((Error?) -> Void))
}

final class SubmitPostPresenter {
    fileprivate let interactor: SubmitPostInteractable

    init(interactor: SubmitPostInteractable) {
        self.interactor = interactor
    }
}

extension SubmitPostPresenter: SubmitPostPresentable {
    func dismiss() {
        interactor.dismiss()
    }

    func submitPost(_ videoURL: URL, title: String, completion: @escaping ((Error?) -> Void)) {
        interactor.submitPost(videoURL, title: title, completion: completion)
    }
}
