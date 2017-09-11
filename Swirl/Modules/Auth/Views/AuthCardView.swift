//
//  AuthCardView.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/10/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

final class AuthCardView: UIView {
    @IBOutlet fileprivate weak var aboutPageView: UIView!
    @IBOutlet fileprivate weak var loginButton: UIButton!
    @IBOutlet fileprivate weak var disclaimerLabel: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
}
