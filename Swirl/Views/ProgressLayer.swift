//
//  ProgressLayer.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/20/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

protocol ProgressAnimatable {
    func grow()
    func pause()
}

private struct Constants {
    private static let maximumVideoCaptureTime = GlobalConstants.maximumVideoCaptureTime
    static let animationDuration: CFTimeInterval = maximumVideoCaptureTime
    static let animationKeyPath = "strokeEnd"
    static let lineWidth: CGFloat = 16
}

final class ProgressLayer: CAShapeLayer {
    fileprivate let animation = CABasicAnimation(keyPath: Constants.animationKeyPath)
    fileprivate let rect: CGRect

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    init(rect: CGRect) {
        self.rect = rect
        super.init()
        path = createPath()
        fillColor = UIColor.lightBlue.cgColor
        strokeColor = UIColor.lightBlue.cgColor
        lineWidth = Constants.lineWidth
        setupAnimation()
    }
}

extension ProgressLayer: ProgressAnimatable {
    func grow() {
        let pausedTime = timeOffset
        speed = 1
        timeOffset = 0
        beginTime = 0
        beginTime = convertTime(CACurrentMediaTime(), from: nil) - pausedTime
    }

    func pause() {
        let pausedTime = convertTime(CACurrentMediaTime(), from: nil)
        speed = 0
        timeOffset = pausedTime
    }
}

fileprivate extension ProgressLayer {
    func setupAnimation() {
        self.pause()
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = Constants.animationDuration
        add(animation, forKey: nil)
    }

    func createPath() -> CGPath {
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path.cgPath
    }
}
