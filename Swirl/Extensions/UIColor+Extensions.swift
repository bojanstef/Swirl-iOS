//
//  UIColor+Extensions.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/9/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

extension UIColor {
    static var veryLightGray: UIColor { return UIColor(r: 234, g: 234, b: 234, a: 1) }
    static var lightBlue: UIColor { return UIColor(r: 168, g: 198, b: 255, a: 1) }

    private convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) { // swiftlint:disable:this identifier_name
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}
