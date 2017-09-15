//
//  ProfileSocialsView.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/15/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

protocol ProfileSocialsViewDelegate: class {
    func postsButtonPressed()
    func followersButtonPressed()
    func followingButtonPressed()
}

private struct Constants {
    static let postTitle = "Posts"
    static let followersTitle = "Followers"
    static let followingTitle = "Following"
    static let newline = NSAttributedString(string: "\n")
    static let hardTextAttributes = [
        NSForegroundColorAttributeName: UIColor.black,
        NSFontAttributeName: UIFont.futura(size: .regular)
    ]
    static let softTextAttributes = [
        NSForegroundColorAttributeName: UIColor.lightGray,
        NSFontAttributeName: UIFont.futura(size: .small)
    ]
}

final class ProfileSocialsView: UIView {
    @IBOutlet fileprivate weak var postsButton: UIButton!
    @IBOutlet fileprivate weak var followersButton: UIButton!
    @IBOutlet fileprivate weak var followingButton: UIButton!
    fileprivate weak var delegate: ProfileSocialsViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        loadNib()
        postsButton.setup()
        followersButton.setup()
        followingButton.setup()
    }

    func setup(with profile: Profile, delegate: ProfileSocialsViewDelegate?) {
        guard let swirlUser = profile.swirlUser else { return }
        self.delegate = delegate

        let postsCount = swirlUser.postUIDs.count
        let postsTitle = createAttributedTitle(postsCount, string: Constants.postTitle)
        postsButton.setAttributedTitle(postsTitle, for: .normal)

        let followersCount = swirlUser.followerUIDs.count
        let followersTitle = createAttributedTitle(followersCount, string: Constants.followersTitle)
        followersButton.setAttributedTitle(followersTitle, for: .normal)

        let followingCount = swirlUser.followingUIDs.count
        let followingTitle = createAttributedTitle(followingCount, string: Constants.followingTitle)
        followingButton.setAttributedTitle(followingTitle, for: .normal)
    }
}

fileprivate extension ProfileSocialsView {
    @IBAction func postsButtonPressed(_ sender: Any) {
        delegate?.postsButtonPressed()
    }

    @IBAction func followersButtonPressed(_ sender: Any) {
        delegate?.followersButtonPressed()
    }

    @IBAction func followingButtonPressed(_ sender: Any) {
        delegate?.followingButtonPressed()
    }

    func createAttributedTitle(_ value: Int, string: String) -> NSAttributedString {
        let title = hardAttributes(String(value))
        title.append(Constants.newline)
        title.append(softAttributes(string))
        return title
    }

    func hardAttributes(_ string: String) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: string, attributes: Constants.hardTextAttributes)
    }

    func softAttributes(_ string: String) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: string, attributes: Constants.softTextAttributes)
    }
}

fileprivate extension UIButton {
    func setup() {
        titleLabel?.numberOfLines = 0
        titleLabel?.textAlignment = .center
    }
}
