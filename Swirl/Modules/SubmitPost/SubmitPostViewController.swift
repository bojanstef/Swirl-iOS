//
//  SubmitPostViewController.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/21/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

final class SubmitPostViewController: UIViewController {
    fileprivate let presenter: SubmitPostPresentable

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    init(presenter: SubmitPostPresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
}
