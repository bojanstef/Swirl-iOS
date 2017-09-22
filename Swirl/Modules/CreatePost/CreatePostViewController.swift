//
//  CreatePostViewController.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/8/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit
import AVKit

private struct Constants {
    static let doubleTap = 2
    static let colorAlpha: CGFloat = 0.25
    static let buttonCornerRadius: CGFloat = 6
    static let progressLayerHeight: CGFloat = 16
    static let minimumHoldToRecordLength: CFTimeInterval = 0.05
    static let buttonEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
}

final class CreatePostDummyViewController: UIViewController {}
final class CreatePostViewController: UIViewController {
    @IBOutlet fileprivate weak var cameraPreview: UIView!
    @IBOutlet fileprivate weak var cameraButton: UIButton!
    @IBOutlet fileprivate weak var dismissButton: UIButton!
    @IBOutlet fileprivate weak var flipCameraButton: UIButton!
    fileprivate weak var progressLayer: ProgressLayer?
    fileprivate let presenter: CreatePostPresentable

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    init(presenter: CreatePostPresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    override var prefersStatusBarHidden: Bool { return true }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startCamera()
        setupNavBar()
        setupButtons()
        setupCameraButton()
        setupCameraPreview()
        setupProgressLayer()
        setupDoubleTapGesture()
    }

    @IBAction func doneButtonPressed(_ sender: Any) {
        presenter.doneRecording { [weak self] videoURL, error in
            if let error = error {
                print(error)
            } else {
                guard let videoURL = videoURL else { print(#function, "No URL"); return }
                self?.showSubmitPost(with: videoURL)
            }
        }
    }
}

fileprivate extension CreatePostViewController {
    @IBAction func dismissButtonPressed(_ sender: Any) {
        progressLayer?.removeFromSuperlayer()
        presenter.stopCamera()
        presenter.dismiss()
    }

    @IBAction func flipCameraButtonPressed(_ sender: Any) {
        presenter.flipCamera()
    }

    @objc func record(_ sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .began: cameraButtonPressed()
        case .ended: cameraButtonReleased()
        default: break
        }
    }

    func cameraButtonPressed() {
        guard presenter.isVideoReady else { return }
        disableAndMakeTransparent(dismissButton)
        disableAndMakeTransparent(flipCameraButton)
        progressLayer?.grow()
        presenter.recordVideo()
    }

    func cameraButtonReleased() {
        enableAndMakeOpaque(dismissButton)
        enableAndMakeOpaque(flipCameraButton)
        progressLayer?.pause()
        presenter.pauseRecording()
    }

    func disableAndMakeTransparent(_ button: UIButton) {
        button.isEnabled = false
        button.alpha = 0
    }

    func enableAndMakeOpaque(_ button: UIButton) {
        button.isEnabled = true
        button.alpha = 1
    }

    func startCamera() {
        do {
            try presenter.startCamera()
        } catch {
            print(error)
        }
    }

    func setupNavBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func setupCameraPreview() {
        let previewLayer = presenter.cameraPreviewLayer(frame: cameraPreview.bounds)
        cameraPreview.layer.insertSublayer(previewLayer, at: 0)
    }

    func setupCameraButton() {
        let recordGestureRecognizer = UILongPressGestureRecognizer(target: self, action: .record)
        recordGestureRecognizer.minimumPressDuration = Constants.minimumHoldToRecordLength
        cameraButton.addGestureRecognizer(recordGestureRecognizer)
    }

    func setupButtons() {
        let seeThroughBlack = UIColor(white: 0, alpha: Constants.colorAlpha)

        dismissButton.backgroundColor = seeThroughBlack
        dismissButton.layer.cornerRadius = Constants.buttonCornerRadius
        dismissButton.imageEdgeInsets = Constants.buttonEdgeInsets

        flipCameraButton.backgroundColor = seeThroughBlack
        flipCameraButton.layer.cornerRadius = Constants.buttonCornerRadius
        flipCameraButton.imageEdgeInsets = Constants.buttonEdgeInsets
    }

    func setupDoubleTapGesture() {
        let flipCameraGestureRecognizer = UITapGestureRecognizer(target: self, action: .flipCamera)
        flipCameraGestureRecognizer.numberOfTapsRequired = Constants.doubleTap
        view.addGestureRecognizer(flipCameraGestureRecognizer)
    }

    func setupProgressLayer() {
        let rect = CGRect(x: 0, y: 0, width: view.frame.width, height: Constants.progressLayerHeight)
        self.progressLayer = ProgressLayer(rect: rect)
        view.layer.addSublayer(progressLayer ?? CALayer())
    }

    func showSubmitPost(with videoURL: URL) {
        presenter.navigateToSubmitPost(with: videoURL)
    }
}

fileprivate extension Selector {
    static let record = #selector(CreatePostViewController.record(_:))
    static let flipCamera = #selector(CreatePostViewController.flipCameraButtonPressed(_:))
}
