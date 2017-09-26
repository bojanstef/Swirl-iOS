//
//  SubmitPostViewController.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/21/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

final class SubmitPostViewController: UIViewController {
    @IBOutlet fileprivate weak var videoPlayerView: VideoPlayerView!
    @IBOutlet fileprivate weak var postTitleView: PostTitleView!
    fileprivate let presenter: SubmitPostPresentable
    fileprivate let videoURL: URL

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    init(presenter: SubmitPostPresentable, videoURL: URL) {
        self.presenter = presenter
        self.videoURL = videoURL
        super.init(nibName: nil, bundle: nil)
    }

    override var prefersStatusBarHidden: Bool { return true }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        videoPlayerView.setVideoURL(videoURL)
        postTitleView.delegate = self
    }
}

extension SubmitPostViewController: PostTitleViewDelegate {
    func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}
