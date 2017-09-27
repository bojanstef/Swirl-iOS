//
//  PostCell.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/11/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

protocol PostSetupable {
    func setup(with post: Post)
}

final class PostCell: UICollectionViewCell {
    @IBOutlet fileprivate weak var testLabel: UILabel!
}

extension PostCell: PostSetupable {
    func setup(with post: Post) {
        testLabel.text = "Owner: \(post.ownerUID)"
    }
}
