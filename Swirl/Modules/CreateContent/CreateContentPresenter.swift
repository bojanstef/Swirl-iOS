//
//  CreateContentPresenter.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/15/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import Foundation

protocol CreateContentPresentable {}

final class CreateContentPresenter {
    fileprivate let interactor: CreateContentInteractable

    init(interactor: CreateContentInteractable) {
        self.interactor = interactor
    }
}

extension CreateContentPresenter: CreateContentPresentable {

}
