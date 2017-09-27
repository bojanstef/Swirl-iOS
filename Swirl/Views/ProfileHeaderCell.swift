//
//  ProfileHeaderCell.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/12/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

protocol ProfileHeaderCellInitializing {
    func setup(with profile: Profile?, delegate: ProfileSocialsViewDelegate?)
}

private struct Constants {
    static let viewsTitle = " " + "views"
    static let totalViewsTextAttributes = [
        NSAttributedStringKey.foregroundColor: UIColor.black,
        NSAttributedStringKey.font: UIFont.futura(size: .small)
    ]
    static let biographyTextAttribues = [
        NSAttributedStringKey.foregroundColor: UIColor.black,
        NSAttributedStringKey.font: UIFont.avenirBook(size: .small)
    ]
}

final class ProfileHeaderCell: UICollectionViewCell {
    @IBOutlet fileprivate weak var displayImageView: UIImageView!
    @IBOutlet fileprivate weak var totalViewsLabel: UILabel!
    @IBOutlet fileprivate weak var profileSocialsView: ProfileSocialsView!
    @IBOutlet fileprivate weak var biographyView: UIView!
    @IBOutlet fileprivate weak var biographyTextView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupBackground()
    }
}

extension ProfileHeaderCell: ProfileHeaderCellInitializing {
    func setup(with profile: Profile?, delegate: ProfileSocialsViewDelegate?) {
        guard let profile = profile else { return }
        displayImageView.image = UIImage(asset: .icon)
        profileSocialsView.setup(with: profile, delegate: delegate)
        setupLabels(with: profile)
    }
}

fileprivate extension ProfileHeaderCell {
    func setupBackground() {
        backgroundColor = .veryLightGray
    }

    func setupLabels(with profile: Profile) {
        biographyTextView.attributedText = NSAttributedString(
            string: profile.swirlUser?.biography ?? String(),
            attributes: Constants.biographyTextAttribues
        )

        totalViewsLabel.backgroundColor = .lightBlue
        totalViewsLabel.attributedText = NSAttributedString(
            string: String(profile.posts.reduce(0) { $0 + $1.loops }).appending(Constants.viewsTitle),
            attributes: Constants.totalViewsTextAttributes
        )
    }
}
