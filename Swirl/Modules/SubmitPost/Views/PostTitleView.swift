//
//  PostTitleView.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/25/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

private struct Constants {
    static let textViewPlaceholder = "Write something creative..."
    static let whiteSeethrough = UIColor(white: 1, alpha: 0.8)
    static let darkSeethrough = UIColor(white: 0, alpha: 0.8)
    static let lightSeethrough = UIColor(white: 0, alpha: 0.2)
    static let buttonCornerRadius: CGFloat = 6
    static let buttonEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
}

protocol PostTitleViewDelegate: class {
    func backButtonPressed()
    func submitButtonPressed()
}

final class PostTitleView: UIView {
    @IBOutlet fileprivate weak var backButton: UIButton!
    @IBOutlet fileprivate weak var submitButton: UIButton!
    @IBOutlet fileprivate weak var textView: UITextView!
    weak var delegate: PostTitleViewDelegate?
    var title: String { return textView.text }

    override func awakeFromNib() {
        super.awakeFromNib()
        loadNib { $0.backgroundColor = .clear }
        backgroundColor = .clear
        setupGradient()
        setupTextView()
        setupButton(backButton)
        setupButton(submitButton)
    }
}

extension PostTitleView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text.isEmpty || textView.text == Constants.textViewPlaceholder {
            textView.text = String()
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = Constants.textViewPlaceholder
        }
    }
}

fileprivate extension PostTitleView {
    @IBAction func backButtonPressed(_ sender: Any) {
        delegate?.backButtonPressed()
    }

    @IBAction func submitButtonPressed(_ sender: Any) {
        delegate?.submitButtonPressed()
    }

    func setupGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [Constants.darkSeethrough.cgColor, Constants.lightSeethrough.cgColor]
        gradient.frame = bounds
        layer.insertSublayer(gradient, at: 0)
    }

    func setupButton(_ button: UIButton) {
        button.backgroundColor = .clear
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.layer.borderColor = Constants.whiteSeethrough.cgColor
        button.layer.borderWidth = 1
        button.imageEdgeInsets = Constants.buttonEdgeInsets
    }

    func setupTextView() {
        textView.delegate = self
        textView.text = Constants.textViewPlaceholder
        textView.textColor = .white
        textView.showsHorizontalScrollIndicator = false
        textView.backgroundColor = .clear
        textView.font = UIFont.avenirBook(size: .small)
    }
}
