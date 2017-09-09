//
//  ProfileViewController.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/8/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

final class ProfileViewController: UIViewController {
    @IBOutlet fileprivate weak var messageLabel: UILabel!
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    fileprivate let message: String

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    init(message: String) {
        self.message = message
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if FBSDKAccessToken.current() == nil {
            print("Damn, you are NOT logged in?!")
        } else {
            print("Congrats, you are logged in!")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        messageLabel.text = message
        loginButton.readPermissions = Constants.readPermissions
    }
}

private struct Constants {
    static let readPermissions = [
        "public_profile",
        "email",
        "user_friends"
    ]
}
