//
//  CreateContentViewController.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/8/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

final class CreateContentViewController: UIViewController {
    fileprivate let presenter: CreateContentPresentable

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    init(presenter: CreateContentPresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
}
