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
    @IBOutlet fileprivate weak var cardView: UIView!
    fileprivate let presenter: AuthPresentable

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    init(presenter: AuthPresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCheerView()
        setupNavBar()
        setupCardView()
    }
}

fileprivate extension AuthViewController {
    func setupCheerView() {
        guard let swirlEmoji = UIImage(asset: .swirlEmoji) else { return }
        let cheerView = CheerView(frame: view.bounds)
        cheerView.backgroundColor = .veryLightGray
        cheerView.config.particle = .image([swirlEmoji])
        cheerView.config.colors = [.blue]
        cheerView.start()
        view.insertSubview(cheerView, at: 0)
    }

    func setupNavBar() {
        navigationItem.titleView = presenter.titleView
    }

    func setupCardView() {
        cardView.layer.shouldRasterize = true
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowColor = UIColor.lightGray.cgColor
        cardView.layer.shadowPath = UIBezierPath(rect: cardView.bounds).cgPath
        cardView.layer.shadowOpacity = 1
        cardView.layer.shadowOffset = CGSize.zero
        cardView.layer.shadowRadius = 10
    }
}
