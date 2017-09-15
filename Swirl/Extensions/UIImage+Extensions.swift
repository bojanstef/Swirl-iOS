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
        /** These cases are grouped as a reminder:
         *  that they are used as the tab bar items **/
        case createContent, curate, discover, following, profile
        case swirlEmoji
        case icon
        case settings
    }

    convenience init?(asset: AssetIdentifier) {
        self.init(named: asset.rawValue)
    }
}
