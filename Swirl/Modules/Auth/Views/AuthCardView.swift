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
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var subtitleLabel: UILabel!
    @IBOutlet fileprivate weak var loginButton: UIButton!
    @IBOutlet fileprivate weak var bottomLabel: UILabel!
    weak var delegate: AuthCardViewDelegate?

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        loadNib { [weak self] view in self?.setup(view) }
        backgroundColor = .clear
        setupLabels()
        setupLoginButton()
    }

    @IBAction fileprivate func loginButtonWasPressed(_ sender: Any) {
        delegate?.loginButtonWasPressed()
    }
}

fileprivate extension AuthCardView {
    func setup(_ view: UIView) {
        view.backgroundColor = UIColor.white.withAlphaComponent(Constants.alphaValue)
        view.layer.cornerRadius = Constants.viewCornerRadius
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        view.layer.shadowOpacity = Constants.shadowOpacity
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = Constants.viewCornerRadius
    }

    func setupLabels() {
        titleLabel.attributedText = NSAttributedString(string: Constants.titleLabelText, attributes: [
            NSFontAttributeName: UIFont(name: Constants.futuraFont, size: Constants.largeFontSize) as Any
        ])

        subtitleLabel.attributedText = NSAttributedString(string: Constants.subtitleLabelText, attributes: [
            NSForegroundColorAttributeName: UIColor.lightGray,
            NSFontAttributeName: UIFont(name: Constants.futuraFont, size: Constants.regularFontSize) as Any
        ])

        bottomLabel.attributedText = NSAttributedString(string: Constants.bottomLabelText, attributes: [
            NSForegroundColorAttributeName: UIColor.lightGray,
            NSFontAttributeName: UIFont(name: Constants.futuraFont, size: Constants.smallFontSize) as Any
        ])
    }

    func setupLoginButton() {
        let attributedTitle = NSAttributedString(string: Constants.buttonText, attributes: [
            NSForegroundColorAttributeName: UIColor.blue.withAlphaComponent(Constants.alphaValue),
            NSFontAttributeName: UIFont(name: Constants.futuraFont, size: Constants.mediumFontSize) as Any
        ])

        loginButton.setAttributedTitle(attributedTitle, for: .normal)
        loginButton.backgroundColor = UIColor.lightBlue.withAlphaComponent(Constants.alphaValue)
        loginButton.layer.cornerRadius = Constants.buttonCornerRadius
    }
}

private struct Constants {
    static let buttonCornerRadius: CGFloat = 4
    static let viewCornerRadius: CGFloat = 10
    static let shadowOpacity: Float = 0.8
    static let alphaValue: CGFloat = 0.8
    static let smallFontSize: CGFloat = 12
    static let regularFontSize: CGFloat = 16
    static let mediumFontSize: CGFloat = 24
    static let largeFontSize: CGFloat = 32
    static let futuraFont = "Futura-Medium"
    static let titleLabelText = "Swirl Video Sharing"
    static let subtitleLabelText = "Create videos and discover what's happening in the World!"
    static let buttonText = "Login with Facebook"
    static let bottomLabelText = "We promise to keep your data safe ♥️"
}
