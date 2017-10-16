//
//  SubmitPostViewController.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/21/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

private struct Constants {
    static let darkSeethrough = UIColor(white: 0, alpha: 0.6)
    static let cornerRadius: CGFloat = 12
    static let activityIndicatorSquare: CGFloat = 128
}

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
        videoPlayerView.setup(videoURL, isMuted: false)
        postTitleView.delegate = self
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissKeyboard()
    }
}

extension SubmitPostViewController: PostTitleViewDelegate {
    func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }

    func submitButtonPressed() {
        dismissKeyboard()
        disableViews()
        presenter.submitPost(videoURL, title: postTitleView.title) { [weak self] error in
            self?.enableViews()
            if let error = error {
                print(error)
            } else {
                self?.presenter.dismiss()
            }
        }
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }

    func disableViews() {
        videoPlayerView.isUserInteractionEnabled = false
        postTitleView.isUserInteractionEnabled = false
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicatorView.frame = CGRect(x: 0, y: 0,
                                             width: Constants.activityIndicatorSquare,
                                             height: Constants.activityIndicatorSquare)
        activityIndicatorView.layer.cornerRadius = Constants.cornerRadius
        activityIndicatorView.backgroundColor = Constants.darkSeethrough
        activityIndicatorView.center = view.center
        activityIndicatorView.startAnimating()
        view.addSubview(activityIndicatorView)
    }

    func enableViews() {
        videoPlayerView.isUserInteractionEnabled = true
        postTitleView.isUserInteractionEnabled = true
        view.subviews.forEach { if $0 is UIActivityIndicatorView { $0.removeFromSuperview() } }
    }
}
