//
//  CameraService.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/17/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import NextLevel
import CoreGraphics
import AVFoundation

protocol CameraServiceable {
    func start() throws
    func stop()
    func requestAuthorizationIfNeeded()
    func previewLayer(frame: CGRect) -> AVCaptureVideoPreviewLayer
}

final class CameraService {
    fileprivate let nextLevel: NextLevel

    static var defaultService: CameraServiceable {
        let nextLevel = NextLevel()
        return CameraService(nextLevel: nextLevel)
    }

    private init(nextLevel: NextLevel) {
        self.nextLevel = nextLevel
    }
}

extension CameraService: CameraServiceable {
    func start() throws {
        try nextLevel.start()
    }

    func stop() {
        nextLevel.stop()
    }

    func requestAuthorizationIfNeeded() {
        testAndRequestAuthorization(for: AVMediaTypeVideo)
        testAndRequestAuthorization(for: AVMediaTypeAudio)
    }

    func previewLayer(frame: CGRect) -> AVCaptureVideoPreviewLayer {
        nextLevel.previewLayer.frame = frame
        return nextLevel.previewLayer
    }
}

fileprivate extension CameraService {
    func authorizationStatus(for mediaType: String) -> NextLevelAuthorizationStatus {
        return nextLevel.authorizationStatus(forMediaType: mediaType)
    }

    func testAndRequestAuthorization(for mediaType: String) {
        guard authorizationStatus(for: mediaType) == .authorized else {
            nextLevel.requestAuthorization(forMediaType: mediaType)
            return
        }
    }
}
