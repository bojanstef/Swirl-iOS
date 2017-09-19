//
//  CreatePostViewController.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/8/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

/*private struct Constants {
    static let tenSeconds: Double = 10
    static let timescale: CMTimeScale = 600
    static let bitRate: Int = 44_000
}*/
final class CreatePostDummyViewController: UIViewController {}
final class CreatePostViewController: UIViewController {
    @IBOutlet fileprivate weak var cameraPreview: UIView!
    fileprivate let presenter: CreatePostPresentable

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    init(presenter: CreatePostPresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    deinit {
        presenter.stopCamera()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
        setupCamera()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.requestCameraAuthorizationIfNeeded()
        do { try presenter.startCamera() } catch { print(error) }
    }
}

fileprivate extension CreatePostViewController {
    dynamic func dismissController() {
        presenter.dismiss()
    }

    func startCamera() {
        try? presenter.startCamera()
    }

    func setupCamera() {
        let previewLayer = presenter.cameraPreviewLayer(frame: cameraPreview.bounds)
        cameraPreview.layer.addSublayer(previewLayer)
    }

    func setupNavBar() {
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                 target: self, action: .dismissController)
        rightBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
}

fileprivate extension Selector {
    static let dismissController = #selector(CreatePostViewController.dismissController)
}
