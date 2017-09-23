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
    static let reactionTime: TimeInterval = 0.1
    static let buttonCornerRadius: CGFloat = 6
    static let minimumHoldToRecordLength: CFTimeInterval = 0.05
    static let seeThroughBlack = UIColor(white: 0, alpha: 0.25)
    static let buttonEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
}

final class CreatePostDummyViewController: UIViewController {}
final class CreatePostViewController: UIViewController {
    @IBOutlet fileprivate weak var cameraPreview: UIView!
    @IBOutlet fileprivate weak var videoDetailsView: VideoDetailsView!
    @IBOutlet fileprivate weak var dismissButton: UIButton!
    @IBOutlet fileprivate weak var flipCameraButton: UIButton!
    @IBOutlet fileprivate weak var undoButton: UIButton!
    @IBOutlet fileprivate weak var cameraButton: UIButton!
    @IBOutlet fileprivate weak var doneButton: UIButton!
    fileprivate weak var updateRecordingTimeTimer: Timer?
    fileprivate let presenter: CreatePostPresentable

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    init(presenter: CreatePostPresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    override var prefersStatusBarHidden: Bool { return true }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        presenter.setSessionCompletion(mergeClipsAndShowPost)
        updateRecordingTimeTimer?.fire()

        setupVideoDetailsView()
        setupDoubleTapGesture()
        setupCameraPreview()
        setupCameraButton()
        setupButtons()
        startCamera()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        updateRecordingTimeTimer?.invalidate()
        presenter.stopCamera()
    }
}

fileprivate extension CreatePostViewController {
    @IBAction func dismissButtonPressed(_ sender: Any) {
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

    @IBAction func undoButtonPressed(_ sender: Any) {
        presenter.removeLastVideoClip()
        videoDetailsView.updateClipsLabel(presenter.videoClipsCount - 1)
    }

    @IBAction func doneButtonPressed(_ sender: Any) {
        mergeClipsAndShowPost()
    }

    func cameraButtonPressed() {
        guard presenter.isVideoReady else { return }
        presenter.recordVideo()
        videoDetailsView.updateClipsLabel(presenter.videoClipsCount)

        disableAndMakeTransparent(dismissButton)
        disableAndMakeTransparent(flipCameraButton)
        disableAndMakeTransparent(undoButton)
        disableAndMakeTransparent(doneButton)
    }

    func cameraButtonReleased() {
        presenter.pauseRecording()

        enableAndMakeOpaque(dismissButton)
        enableAndMakeOpaque(flipCameraButton)
        enableAndMakeOpaque(undoButton)
        enableAndMakeOpaque(doneButton)
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

    func mergeClipsAndShowPost() {
        presenter.doneRecording { [weak self] videoURL, error in
            if let error = error {
                print(error)
            } else {
                guard let videoURL = videoURL else { print(#function, "No URL"); return }
                self?.showSubmitPost(with: videoURL)
            }
        }
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
        setupButtonHelper(dismissButton)
        setupButtonHelper(flipCameraButton)
        setupButtonHelper(undoButton)
        setupButtonHelper(doneButton)
    }

    func setupButtonHelper(_ button: UIButton) {
        enableAndMakeOpaque(button)
        button.backgroundColor = Constants.seeThroughBlack
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.imageEdgeInsets = Constants.buttonEdgeInsets
    }

    func setupDoubleTapGesture() {
        let flipCameraGestureRecognizer = UITapGestureRecognizer(target: self, action: .flipCamera)
        flipCameraGestureRecognizer.numberOfTapsRequired = Constants.doubleTap
        view.addGestureRecognizer(flipCameraGestureRecognizer)
    }

    func showSubmitPost(with videoURL: URL) {
        guard let navigationController = navigationController else { return }
        presenter.navigateToSubmitPost(from: navigationController, with: videoURL)
    }

    func setupVideoDetailsView() {
        videoDetailsView.backgroundColor = Constants.seeThroughBlack
        videoDetailsView.layer.cornerRadius = Constants.buttonCornerRadius
        videoDetailsView.updateClipsLabel(0)
        videoDetailsView.updateTimeLabel(0)
        updateRecordingTimeTimer = Timer
            .scheduledTimer(withTimeInterval: Constants.reactionTime, repeats: true) { [weak self] _ in

            guard let this = self else { return }
            this.videoDetailsView.updateTimeLabel(this.presenter.videoTotalTime.seconds)
        }
    }
}

fileprivate extension Selector {
    static let record = #selector(CreatePostViewController.record(_:))
    static let flipCamera = #selector(CreatePostViewController.flipCameraButtonPressed(_:))
}
