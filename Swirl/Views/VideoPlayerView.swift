//
//  VideoPlayerView.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/21/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit
import AVFoundation

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
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = self.bounds
        self.layer.addSublayer(playerLayer)
        player?.play()
    }
}

fileprivate extension Selector {
    static let loopVideo = #selector(VideoPlayerView.loopVideo)
}
