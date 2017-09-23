//
//  ControllerGettable.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/8/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

@objc protocol ControllerGettable {
    @objc optional var viewController: UIViewController { get }
    @objc optional var tabBarController: UIViewController { get }
}
