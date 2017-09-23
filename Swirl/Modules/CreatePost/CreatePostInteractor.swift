//
//  CreatePostInteractor.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/15/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit
import CoreGraphics.CGGeometry
import AVFoundation.AVCaptureVideoPreviewLayer

protocol CreatePostInteractable {
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

    var videoClipsCount: Int {
        return cameraService.clipCount
    }

    var videoTotalTime: CMTime {
        return cameraService.totalTime
    }

    func setSessionCompletion(_ completion: @escaping (() -> Void)) {
        cameraService.setSessionCompletion(completion)
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

    func removeLastVideoClip() {
        cameraService.removeLastClip()
    }

    func dismiss() {
        moduleDelegate?.dismiss()
    }

    func navigateToSubmitPost(from navigationController: UINavigationController, with videoURL: URL) {
        moduleDelegate?.navigateToSubmitPost(from: navigationController, with: videoURL)
    }
}
