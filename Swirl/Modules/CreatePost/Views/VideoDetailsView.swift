//
//  VideoDetailsView.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/22/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

protocol VideoDetailsViewUpdateable {
    func updateClipsLabel(_ number: Int)
    func updateTimeLabel(_ seconds: Double)
}

final class VideoDetailsView: UIView {
    @IBOutlet fileprivate weak var clipsLabel: UILabel!
    @IBOutlet fileprivate weak var clipsCountLabel: UILabel!
    @IBOutlet fileprivate weak var timeLabel: UILabel!
    @IBOutlet fileprivate weak var timeSecondsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        loadNib { $0.backgroundColor = .clear }
        backgroundColor = .clear
        setupLabels()
    }
}

extension VideoDetailsView: VideoDetailsViewUpdateable {
    func updateClipsLabel(_ number: Int) {
        let text = String(number)
        clipsCountLabel.attributedText = NSAttributedString(string: text, attributes: [
            .foregroundColor: UIColor.white,
            .font: UIFont.futura(size: .small)
        ])
    }

    func updateTimeLabel(_ seconds: Double) {
        let text = String(format: "%.1fs", seconds)
        timeSecondsLabel.attributedText = NSAttributedString(string: text, attributes: [
            .foregroundColor: UIColor.white,
            .font: UIFont.futura(size: .small)
        ])
    }
}

fileprivate extension VideoDetailsView {
    func setupLabels() {
        labelSetupHelper(clipsLabel, text: "CLIPS")
        labelSetupHelper(clipsCountLabel, text: "0")
        labelSetupHelper(timeLabel, text: "TIME")
        labelSetupHelper(timeSecondsLabel, text: "0")
    }

    func labelSetupHelper(_ label: UILabel, text: String) {
        label.attributedText = NSAttributedString(string: text, attributes: [
            .foregroundColor: UIColor.white,
            .font: UIFont.futura(size: .small)
        ])
    }
}
