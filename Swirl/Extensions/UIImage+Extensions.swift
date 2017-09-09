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
        case discover
    }

    convenience init?(asset: AssetIdentifier) {
        self.init(named: asset.rawValue)
    }
}
