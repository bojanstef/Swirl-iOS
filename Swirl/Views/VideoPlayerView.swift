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
    static let seeThroughBlack = UIColor(white: 0, alpha: 0.25)
    static let viewCornerRadius: CGFloat = 6
    static let viewEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
}

final class VideoPlayerView: UIView {
    fileprivate var player: AVPlayer?
    fileprivate var videoURL: URL? { didSet { setupVideoPlayer() } }
    fileprivate var isMuted = true

    override func awakeFromNib() {
        super.awakeFromNib()
        loadNib { $0.backgroundColor = .clear }
        setupLooping()
    }

    deinit {
        NotificationCenter.default.removeObserver(
            self, name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: nil
        )
    }

    func setup(_ videoURL: URL, isMuted: Bool) {
        self.videoURL = videoURL
        self.isMuted = isMuted
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
        layer.insertSublayer(playerLayer, at: 0)
        player?.isMuted = isMuted
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
