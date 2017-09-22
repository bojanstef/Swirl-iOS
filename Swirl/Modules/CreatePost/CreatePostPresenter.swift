//
//  CreatePostPresenter.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/15/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import Foundation
import CoreGraphics.CGGeometry
import AVFoundation.AVCaptureVideoPreviewLayer

protocol CreatePostPresentable {
    var isVideoReady: Bool { get }
    func startCamera() throws
    func stopCamera()
    func cameraPreviewLayer(frame: CGRect) -> AVCaptureVideoPreviewLayer
    func recordVideo()
    func pauseRecording()
    func doneRecording(completion: @escaping ((URL?, Error?) -> Void))
    func flipCamera()
    func dismiss()
    func navigateToSubmitPost(with videoURL: URL)
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

    func dismiss() {
        interactor.dismiss()
    }

    func navigateToSubmitPost(with videoURL: URL) {
        interactor.navigateToSubmitPost(with: videoURL)
    }
}
