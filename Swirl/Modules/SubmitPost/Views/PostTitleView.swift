//
//  PostTitleView.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/25/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

private struct Constants {
    static let buttonCornerRadius: CGFloat = 6
    static let buttonEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
}

protocol PostTitleViewDelegate: class {
    func backButtonPressed()
}

final class PostTitleView: UIView {
    @IBOutlet fileprivate var backButton: UIButton!
    @IBOutlet fileprivate var textView: UITextView!
    weak var delegate: PostTitleViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        loadNib { $0.backgroundColor = .clear }
        backgroundColor = .clear
        setupGradient()
        setupButton()
    }
}

fileprivate extension PostTitleView {
    @IBAction func backButtonPressed(_ sender: Any) {
        delegate?.backButtonPressed()
    }

    func setupGradient() {
        let dark = UIColor(white: 0, alpha: 0.8).cgColor
        let light = UIColor(white: 0, alpha: 0.2).cgColor
        let gradient = CAGradientLayer()
        gradient.colors = [dark, light]
        gradient.locations = [0.2, 0.8]
        gradient.frame = bounds
        layer.insertSublayer(gradient, at: 0)
    }

    func setupButton() {
        backButton.backgroundColor = .clear
        backButton.layer.cornerRadius = Constants.buttonCornerRadius
        backButton.layer.borderColor = UIColor(white: 1, alpha: 0.8).cgColor
        backButton.layer.borderWidth = 1
        backButton.imageEdgeInsets = Constants.buttonEdgeInsets
    }
}
