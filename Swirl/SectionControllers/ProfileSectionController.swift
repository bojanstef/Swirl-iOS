//
//  ProfileSectionController.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/11/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import IGListKit

private struct Constants {
    static let spaceBetweenCells: CGFloat = 2
    static let headerHeight: CGFloat = 256 + 44 + 64
}

final class ProfileSectionController: ListSectionController {
    fileprivate weak var delegate: ProfileSocialsViewDelegate?
    fileprivate var profile: Profile?

    init(delegate: ProfileSocialsViewDelegate?) {
        self.delegate = delegate
        super.init()
        supplementaryViewSource = self
        minimumLineSpacing = Constants.spaceBetweenCells
        minimumInteritemSpacing = Constants.spaceBetweenCells
    }

    override func numberOfItems() -> Int {
        guard let posts = profile?.posts else { return 0 }
        return posts.count
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let containerWidth = collectionContext?.containerSize.width else { return .zero }
        let squareSize = (containerWidth / 3) - Constants.spaceBetweenCells
        return CGSize(width: squareSize, height: squareSize)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let nibName = String(describing: PostCell.self)
        guard let cell = collectionContext?
            .dequeueReusableCell(withNibName: nibName, bundle: nil, for: self, at: index)
            as? PostCell else { fatalError(#function) }
        if let post = profile?.posts[index] { cell.setup(with: post) }
        return cell
    }

    override func didUpdate(to object: Any) {
        profile = object as? Profile
    }

    override func didSelectItem(at index: Int) {
        print(#function, profile?.posts[index].title as Any)
    }
}

extension ProfileSectionController: ListSupplementaryViewSource {
    func supportedElementKinds() -> [String] {
        return [UICollectionElementKindSectionHeader]
    }

    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        let headerKind = UICollectionElementKindSectionHeader
        let nibName = String(describing: ProfileHeaderCell.self)
        guard let view = collectionContext?
            .dequeueReusableSupplementaryView(ofKind: headerKind, for: self, nibName: nibName, bundle: nil, at: index)
            as? ProfileHeaderCell else { fatalError(#function) }
        view.setup(with: profile, delegate: delegate)
        return view
    }

    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { return .zero }
        return CGSize(width: width, height: Constants.headerHeight)
    }
}
