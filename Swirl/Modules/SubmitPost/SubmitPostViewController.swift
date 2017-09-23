//
//  SubmitPostViewController.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/21/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

private struct Constants {
    static let colorAlpha: CGFloat = 0.25
    static let buttonCornerRadius: CGFloat = 6
    static let buttonEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
}

final class SubmitPostViewController: UIViewController {
    @IBOutlet fileprivate weak var videoPlayerView: VideoPlayerView!
    @IBOutlet fileprivate weak var backButton: UIButton!
    fileprivate let presenter: SubmitPostPresentable
    fileprivate let videoURL: URL

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    init(presenter: SubmitPostPresentable, videoURL: URL) {
        self.presenter = presenter
        self.videoURL = videoURL
        super.init(nibName: nil, bundle: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        videoPlayerView.setVideoURL(videoURL)
        setupButtons()
    }
}

fileprivate extension SubmitPostViewController {
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    func setupButtons() {
        let seeThroughBlack = UIColor(white: 0, alpha: Constants.colorAlpha)

        backButton.backgroundColor = seeThroughBlack
        backButton.layer.cornerRadius = Constants.buttonCornerRadius
        backButton.imageEdgeInsets = Constants.buttonEdgeInsets
    }
}
