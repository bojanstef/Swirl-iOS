//
//  PostCell.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/11/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit
import AVKit

protocol PostSetupable {
    func setup(with post: Post)
}

final class PostCell: UICollectionViewCell {
    @IBOutlet fileprivate weak var thumbnail: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
    }
}

extension PostCell: PostSetupable {
    func setup(with post: Post) {
        guard let videoURL = URL(string: post.url) else { return }
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            let thumbnailImage = self?.createThumbnail(from: videoURL)
            DispatchQueue.main.async {
                self?.thumbnail.image = thumbnailImage
            }
        }
    }
}

fileprivate extension PostCell {
    func createThumbnail(from url: URL) -> UIImage? {
        do {
            let asset = AVURLAsset(url: url, options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTime(value: 0, timescale: 1), actualTime: nil)
            return UIImage(cgImage: cgImage)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}
