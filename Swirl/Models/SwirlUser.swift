//
//  SwirlUser.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/11/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import IGListKit

final class SwirlUser: Codable {
    let uid: String
    let username: String
    let biography: String
    let postUIDs: [String]
    let followerUIDs: [String]
    let followingUIDs: [String]
    let photoURL: String?

    init(uid: String, username: String, biography: String = String(), postUIDs: [String] = [],
         followerUIDs: [String] = [], followingUIDs: [String] = [], photoURL: String? = nil) {

        self.uid = uid
        self.username = username
        self.biography = biography
        self.postUIDs = postUIDs
        self.followerUIDs = followerUIDs
        self.followingUIDs = followingUIDs
        self.photoURL = photoURL
    }

    func encode() throws -> [String: Any]? {
        let jsonData = try JSONEncoder().encode(self)
        return try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
    }
}

extension SwirlUser: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return NSString(string: uid)
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let swirlUser = object as? SwirlUser else { return false }
        return self == swirlUser
    }
}

extension SwirlUser: Equatable {
    // ISSUE: - https://github.com/bojanstef/Swirl-iOS/issues/5
    static func == (lhs: SwirlUser, rhs: SwirlUser) -> Bool {
        return lhs.uid == rhs.uid
            && lhs.username == rhs.username
            && lhs.biography == rhs.biography
            && lhs.postUIDs.count == rhs.postUIDs.count
            && lhs.followerUIDs.count == rhs.followerUIDs.count
            && lhs.followingUIDs.count == rhs.followingUIDs.count
            && lhs.photoURL == rhs.photoURL
    }
}
