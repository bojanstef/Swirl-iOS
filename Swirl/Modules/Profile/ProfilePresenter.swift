//
//  ProfilePresenter.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/11/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import Foundation

protocol ProfilePresentable {
    var message: String { get }
}

final class ProfilePresenter {
    fileprivate let interactor: ProfileInteractable

    init(interactor: ProfileInteractable) {
        self.interactor = interactor
    }
}

extension ProfilePresenter: ProfilePresentable {
    var message: String {
        return "Profile Works!"
    }
}
