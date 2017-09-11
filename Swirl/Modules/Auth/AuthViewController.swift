//
//  AuthViewController.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/9/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit
import Cheers

final class AuthViewController: UIViewController {
    @IBOutlet fileprivate weak var authCardView: AuthCardView!
    fileprivate let presenter: AuthPresentable

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    init(presenter: AuthPresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        authCardView.delegate = self
        setupNavBar()
        setupCheerView()
    }
}

extension AuthViewController: AuthCardViewDelegate {
    func loginButtonWasPressed() {
        presenter.requestLogin(with: self) { [weak self] success, error in
            guard success, error == nil else { print("Auth Failed."); return }
            self?.navigateToMain()
        }
    }
}

fileprivate extension AuthViewController {
    func setupNavBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func setupCheerView() {
        guard let swirlEmoji = UIImage(asset: .swirlEmoji) else { return }
        let cheerView = CheerView(frame: view.bounds)
        cheerView.backgroundColor = .veryLightGray
        cheerView.config.particle = .image([swirlEmoji])
        cheerView.config.colors = [.blue]
        cheerView.start()
        view.insertSubview(cheerView, at: 0)
    }

    func navigateToMain() {
        presenter.loginSucceeded()
    }
}
