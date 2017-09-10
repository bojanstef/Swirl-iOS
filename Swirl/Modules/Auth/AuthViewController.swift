//
//  AuthViewController.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/9/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

final class AuthViewController: UIViewController {
    fileprivate let presenter: AuthPresenter

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    init(presenter: AuthPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
