//
//  AuthViewController.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/9/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit
import Cheers

private struct Constant {
    static let circle: CGFloat = 2 * .pi
    static let rotationDampening: CGFloat = 0.01
}

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
        setupAuthCardView()
        setupNavBar()
        setupCheerView()
    }
}

extension AuthViewController: AuthCardViewDelegate {
    func loginButtonWasPressed(completion: @escaping (() -> Void)) {
        presenter.requestLogin(with: self) { [weak self] success, error in
            completion() // Both on success or fail: enable the login button.
            guard success, error == nil else { print(#function, "TODO: - Alert."); return }
            self?.navigateToMain()
        }
    }
}

fileprivate extension AuthViewController {
    dynamic func dragAuthCardView(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let xTranslation = authCardView.center.x + translation.x
        let yTranslation = authCardView.center.y + translation.y
        authCardView.center = CGPoint(x: xTranslation, y: yTranslation)
        sender.setTranslation(.zero, in: view)

        let difference = authCardView.center.x - view.center.x
        let rotationAngle = difference * Constant.circle * Constant.rotationDampening
        authCardView.transform = CGAffineTransform(rotationAngle: rotationAngle)

        if sender.state == .ended { resetAuthCardView() }
    }

    func resetAuthCardView() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let this = self else { return }
            this.authCardView.center = this.view.center
            this.authCardView.transform = CGAffineTransform(rotationAngle: 0)
        }
    }

    func setupAuthCardView() {
        authCardView.delegate = self
        authCardView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: .dragAuthCardView))
    }

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

fileprivate extension Selector {
    static let dragAuthCardView = #selector(AuthViewController.dragAuthCardView(_:))
}
