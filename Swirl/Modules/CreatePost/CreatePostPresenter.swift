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
    func startCamera() throws
    func stopCamera()
    func requestCameraAuthorizationIfNeeded()
    func cameraPreviewLayer(frame: CGRect) -> AVCaptureVideoPreviewLayer
    func dismiss()
}

final class CreatePostPresenter {
    fileprivate let interactor: CreatePostInteractable

    init(interactor: CreatePostInteractable) {
        self.interactor = interactor
    }
}

extension CreatePostPresenter: CreatePostPresentable {
    func startCamera() throws {
        try interactor.startCamera()
    }

    func stopCamera() {
        interactor.stopCamera()
    }

    func requestCameraAuthorizationIfNeeded() {
        interactor.requestCameraAuthorizationIfNeeded()
    }

    func cameraPreviewLayer(frame: CGRect) -> AVCaptureVideoPreviewLayer {
        return interactor.cameraPreviewLayer(frame: frame)
    }

    func dismiss() {
        interactor.dismiss()
    }
}
