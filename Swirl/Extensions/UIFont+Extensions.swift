//
//  UIFont+Extensions.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/13/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

enum FontSize: CGFloat {
    case small = 12
    case regular = 16
    case medium = 20
    case large = 32
}

private struct Constants {
    static let futura = "Futura-Medium"
    static let avenirBook = "Avenir-Book"
}

extension UIFont {
    static func futura(size: FontSize) -> UIFont {
        let descriptor = UIFontDescriptor(name: Constants.futura, size: size.rawValue)
        return UIFont(descriptor: descriptor, size: size.rawValue)
    }

    static func avenirBook(size: FontSize) -> UIFont {
        let descriptor = UIFontDescriptor(name: Constants.avenirBook, size: size.rawValue)
        return UIFont(descriptor: descriptor, size: size.rawValue)
    }
}
