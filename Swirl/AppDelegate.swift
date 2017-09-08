//
//  AppDelegate.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/8/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder {
    var window: UIWindow?
    fileprivate var rootCoorindator: RootCoordinator?
}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        if let window = window {
            rootCoorindator = RootCoordinator(window: window)
            rootCoorindator?.start()
            return true
        } else {
            return false
        }
    }
}
