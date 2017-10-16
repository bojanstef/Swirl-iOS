//
//  UIImage+Extensions.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/8/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

extension UIImage {
    enum AssetIdentifier: String {
        /** The top cases are grouped as a reminder:
         *  that they are used as the tab bar items **/
        case createPost, curate, discover, following, profile
        case backArrow, rightArrow, downArrow

        case swirlEmoji
        case swirlButton
        case icon
        case settings
        case undoButton
        case flipCamera
        case mute
        case volume
    }

    convenience init?(asset: AssetIdentifier) {
        self.init(named: asset.rawValue)
    }
}
