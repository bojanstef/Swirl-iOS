//
//  CreatePostPresenter.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/15/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit
import CoreGraphics.CGGeometry
import AVFoundation.AVCaptureVideoPreviewLayer

protocol CreatePostPresentable {
    var isVideoReady: Bool { get }
    var videoClipsCount: Int { get }
    var videoTotalTime: CMTime { get }
    func setSessionCompletion(_ completion: @escaping (() -> Void))
    func startCamera() throws
    func stopCamera()
    func cameraPreviewLayer(frame: CGRect) -> AVCaptureVideoPreviewLayer
    func recordVideo()
    func pauseRecording()
    func doneRecording(completion: @escaping ((URL?, Error?) -> Void))
    func flipCamera()
    func removeLastVideoClip()
    func dismiss()
    func navigateToSubmitPost(from navigationController: UINavigationController, with videoURL: URL)
}

final class CreatePostPresenter {
    fileprivate let interactor: CreatePostInteractable

    init(interactor: CreatePostInteractable) {
        self.interactor = interactor
    }
}

extension CreatePostPresenter: CreatePostPresentable {
    var isVideoReady: Bool {
        return interactor.isVideoReady
    }

    var videoClipsCount: Int {
        return interactor.videoClipsCount
    }

    var videoTotalTime: CMTime {
        return interactor.videoTotalTime
    }

    func setSessionCompletion(_ completion: @escaping (() -> Void)) {
        interactor.setSessionCompletion(completion)
    }

    func startCamera() throws {
        try interactor.startCamera()
    }

    func stopCamera() {
        interactor.stopCamera()
    }

    func cameraPreviewLayer(frame: CGRect) -> AVCaptureVideoPreviewLayer {
        return interactor.cameraPreviewLayer(frame: frame)
    }

    func recordVideo() {
        interactor.recordVideo()
    }

    func pauseRecording() {
        interactor.pauseRecording()
    }

    func doneRecording(completion: @escaping ((URL?, Error?) -> Void)) {
        interactor.doneRecording(completion: completion)
    }

    func flipCamera() {
        interactor.flipCamera()
    }

    func removeLastVideoClip() {
        interactor.removeLastVideoClip()
    }

    func dismiss() {
        interactor.dismiss()
    }

    func navigateToSubmitPost(from navigationController: UINavigationController, with videoURL: URL) {
        interactor.navigateToSubmitPost(from: navigationController, with: videoURL)
    }
}
