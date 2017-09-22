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
    var isVideoReady: Bool {
        return cameraService.isVideoReady
    }

    func startCamera() throws {
        try cameraService.start()
    }

    func stopCamera() {
        cameraService.stop()
    }

    func cameraPreviewLayer(frame: CGRect) -> AVCaptureVideoPreviewLayer {
        return cameraService.previewLayer(frame: frame)
    }

    func recordVideo() {
        cameraService.record()
    }

    func pauseRecording() {
        cameraService.pause()
    }

    func doneRecording(completion: @escaping ((URL?, Error?) -> Void)) {
        cameraService.doneRecording(completion: completion)
    }

    func flipCamera() {
        cameraService.flipCamera()
    }

    func dismiss() {
        moduleDelegate?.dismiss()
    }

    func navigateToSubmitPost(with videoURL: URL) {
        moduleDelegate?.navigateToSubmitPost(with: videoURL)
    }
}
