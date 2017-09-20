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
    func record()
    func pause()
}

final class CameraService: NSObject {
    fileprivate let nextLevel: NextLevel

    static var defaultService: CameraServiceable {
        let nextLevel = NextLevel()
        return CameraService(nextLevel: nextLevel)
    }

    private init(nextLevel: NextLevel) {
        self.nextLevel = nextLevel
        super.init()
        self.nextLevel.delegate = self
        self.nextLevel.videoDelegate = self
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
        testAndRequestAuthorization(for: AVMediaType.video)
        testAndRequestAuthorization(for: AVMediaType.audio)
    }

    func previewLayer(frame: CGRect) -> AVCaptureVideoPreviewLayer {
        nextLevel.previewLayer.frame = frame
        return nextLevel.previewLayer
    }

    func record() {
        nextLevel.record()
    }

    func pause() {
        nextLevel.pause()
    }
}

extension CameraService: NextLevelDelegate {
    func nextLevel(_ nextLevel: NextLevel, didUpdateAuthorizationStatus status: NextLevelAuthorizationStatus,
                   forMediaType mediaType: AVMediaType) {}
    func nextLevel(_ nextLevel: NextLevel,
                   didUpdateVideoConfiguration videoConfiguration: NextLevelVideoConfiguration) {}
    func nextLevel(_ nextLevel: NextLevel,
                   didUpdateAudioConfiguration audioConfiguration: NextLevelAudioConfiguration) {}
    func nextLevelSessionWillStart(_ nextLevel: NextLevel) {}
    func nextLevelSessionDidStart(_ nextLevel: NextLevel) {}
    func nextLevelSessionDidStop(_ nextLevel: NextLevel) {}
    func nextLevelSessionWasInterrupted(_ nextLevel: NextLevel) {}
    func nextLevelSessionInterruptionEnded(_ nextLevel: NextLevel) {}
    func nextLevelWillStartPreview(_ nextLevel: NextLevel) {}
    func nextLevelDidStopPreview(_ nextLevel: NextLevel) {}
    func nextLevelCaptureModeWillChange(_ nextLevel: NextLevel) {}
    func nextLevelCaptureModeDidChange(_ nextLevel: NextLevel) {}
}

extension CameraService: NextLevelVideoDelegate {
    func nextLevel(_ nextLevel: NextLevel, didUpdateVideoZoomFactor videoZoomFactor: Float) {}
    func nextLevel(_ nextLevel: NextLevel, willProcessRawVideoSampleBuffer sampleBuffer: CMSampleBuffer,
                   onQueue queue: DispatchQueue) {}
    func nextLevel(_ nextLevel: NextLevel, renderToCustomContextWithImageBuffer imageBuffer: CVPixelBuffer,
                   onQueue queue: DispatchQueue) {}
    func nextLevel(_ nextLevel: NextLevel, didSetupVideoInSession session: NextLevelSession) {}
    func nextLevel(_ nextLevel: NextLevel, didSetupAudioInSession session: NextLevelSession) {}
    func nextLevel(_ nextLevel: NextLevel, didStartClipInSession session: NextLevelSession) {}
    func nextLevel(_ nextLevel: NextLevel, didCompleteClip clip: NextLevelClip, inSession session: NextLevelSession) {}
    func nextLevel(_ nextLevel: NextLevel, didAppendVideoSampleBuffer sampleBuffer: CMSampleBuffer,
                   inSession session: NextLevelSession) {}
    func nextLevel(_ nextLevel: NextLevel, didAppendAudioSampleBuffer sampleBuffer: CMSampleBuffer,
                   inSession session: NextLevelSession) {}
    func nextLevel(_ nextLevel: NextLevel, didSkipVideoSampleBuffer sampleBuffer: CMSampleBuffer,
                   inSession session: NextLevelSession) {}
    func nextLevel(_ nextLevel: NextLevel, didSkipAudioSampleBuffer sampleBuffer: CMSampleBuffer,
                   inSession session: NextLevelSession) {}
    func nextLevel(_ nextLevel: NextLevel, didCompleteSession session: NextLevelSession) {}
    func nextLevel(_ nextLevel: NextLevel, didCompletePhotoCaptureFromVideoFrame photoDict: [String : Any]?) {}
}

fileprivate extension CameraService {
    func authorizationStatus(for mediaType: AVMediaType) -> NextLevelAuthorizationStatus {
        return nextLevel.authorizationStatus(forMediaType: mediaType)
    }

    func testAndRequestAuthorization(for mediaType: AVMediaType) {
        guard authorizationStatus(for: mediaType) == .authorized else {
            nextLevel.requestAuthorization(forMediaType: mediaType)
            return
        }
    }
}
