//
//  Profile.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/15/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import IGListKit

final class Profile {
    let swirlUser: SwirlUser?
    let posts: [Post]

    init(swirlUser: SwirlUser?, posts: [Post]) {
        self.swirlUser = swirlUser
        self.posts = posts
    }

    convenience init() {
        self.init(swirlUser: nil, posts: [])
    }

    func update(_ swirlUser: SwirlUser? = nil, posts: [Post]? = nil) -> Profile {
        return Profile(swirlUser: swirlUser ?? self.swirlUser, posts: posts ?? self.posts)
    }
}

extension Profile: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return NSString(string: swirlUser?.uid ?? String())
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let profile = object as? Profile else { return false }
        return self == profile
    }
}

extension Profile: Equatable {
    static func == (lhs: Profile, rhs: Profile) -> Bool {
        return lhs.swirlUser == rhs.swirlUser
            && lhs.posts.count == rhs.posts.count
    }
}
