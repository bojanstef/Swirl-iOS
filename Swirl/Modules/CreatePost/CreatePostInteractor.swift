//
//  CreatePostInteractor.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/15/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import Foundation
import CoreGraphics.CGGeometry
import AVFoundation.AVCaptureVideoPreviewLayer

protocol CreatePostInteractable {
    func startCamera() throws
    func stopCamera()
    func requestCameraAuthorizationIfNeeded()
    func cameraPreviewLayer(frame: CGRect) -> AVCaptureVideoPreviewLayer
    func dismiss()
}

final class CreatePostInteractor {
    fileprivate weak var moduleDelegate: CreatePostModuleDelegate?
    fileprivate let dataService: CreatePostDataServiceable
    fileprivate let cameraService: CameraServiceable

    init(moduleDelegate: CreatePostModuleDelegate?,
         dataService: CreatePostDataServiceable,
         cameraService: CameraServiceable) {

        self.moduleDelegate = moduleDelegate
        self.dataService = dataService
        self.cameraService = cameraService
    }
}

extension CreatePostInteractor: CreatePostInteractable {
    func startCamera() throws {
        try cameraService.start()
    }

    func stopCamera() {
        cameraService.stop()
    }

    func requestCameraAuthorizationIfNeeded() {
        cameraService.requestAuthorizationIfNeeded()
    }

    func cameraPreviewLayer(frame: CGRect) -> AVCaptureVideoPreviewLayer {
        return cameraService.previewLayer(frame: frame)
    }

    func dismiss() {
        moduleDelegate?.dismiss()
    }
}
