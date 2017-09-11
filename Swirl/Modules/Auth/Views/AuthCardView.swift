//
//  AuthCardView.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/10/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

protocol AuthCardViewDelegate: class {
    func loginButtonWasPressed()
}

final class AuthCardView: UIView {
    @IBOutlet fileprivate weak var aboutPageView: UIView!
    @IBOutlet fileprivate weak var loginButton: UIButton!
    @IBOutlet fileprivate weak var bottomLabel: UILabel!
    weak var delegate: AuthCardViewDelegate?
    var bottomText: NSAttributedString? {
        didSet { updateBottomLabel(with: bottomText) }
    }

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        loadNib { [weak self] view in
            self?.setup(view)
        }

        backgroundColor = UIColor.white.withAlphaComponent(0)
    }

    @IBAction fileprivate func loginButtonWasPressed(_ sender: Any) {
        delegate?.loginButtonWasPressed()
    }
}

fileprivate extension AuthCardView {
    func setup(_ view: UIView) {
        view.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 10
    }

    func updateBottomLabel(with text: NSAttributedString?) {
        bottomLabel.attributedText = text
    }
}
