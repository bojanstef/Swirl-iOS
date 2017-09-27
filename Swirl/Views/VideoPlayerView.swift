//
//  VideoPlayerView.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/21/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit
import AVFoundation

private struct Constants {
    static let viewCornerRadius: CGFloat = 10
    static let shadowOpacity: Float = 0.8
    static let alphaValue: CGFloat = 0.8
}

final class VideoPlayerView: UIView {
    fileprivate var player: AVPlayer?
    fileprivate var videoURL: URL? { didSet { setupVideoPlayer() } }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupLooping()
    }

    deinit {
        NotificationCenter.default.removeObserver(
            self, name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: nil
        )
    }

    func setVideoURL(_ videoURL: URL) {
        self.videoURL = videoURL
    }
}

fileprivate extension VideoPlayerView {
    @objc func loopVideo() {
        player?.seek(to: kCMTimeZero)
        player?.play()
    }

    func setupLooping() {
        NotificationCenter.default.addObserver(
            self, selector: .loopVideo, name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: nil
        )
    }

    func setupVideoPlayer() {
        guard let videoURL = videoURL else { return }
        player = AVPlayer(url: videoURL)
        let playerLayer = createPlayerLayer(with: player)
        layer.addSublayer(playerLayer)
        player?.play()
    }

    func createPlayerLayer(with player: AVPlayer?) -> AVPlayerLayer {
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = bounds
        return playerLayer
    }
}

fileprivate extension Selector {
    static let loopVideo = #selector(VideoPlayerView.loopVideo)
}
