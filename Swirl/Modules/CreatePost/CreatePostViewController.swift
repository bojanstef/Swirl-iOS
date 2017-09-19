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

final class CreatePostViewController: UIViewController {
    @IBOutlet fileprivate weak var cameraPreview: UIView!
    fileprivate let presenter: CreatePostPresentable

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    init(presenter: CreatePostPresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.requestCameraAuthorizationIfNeeded()
        do { try presenter.startCamera() } catch { print(error) }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.stopCamera()
    }
}

fileprivate extension CreatePostViewController {
    func startCamera() {
        do {
            try presenter.startCamera()
        } catch {
            print(error)
        }
    }

    func setupCamera() {
        let previewLayer = presenter.cameraPreviewLayer(frame: cameraPreview.bounds)
        cameraPreview.layer.addSublayer(previewLayer)
    }
}
