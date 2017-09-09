//
//  CreateContentViewController.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/8/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

final class CreateContentViewController: UIViewController {
    @IBOutlet fileprivate weak var messageLabel: UILabel!
    fileprivate let message: String

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    init(message: String) {
        self.message = message
        super.init(nibName: nil, bundle: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        messageLabel.text = message
    }
}
