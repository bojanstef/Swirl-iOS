//
//  SwirlUser.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/11/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import IGListKit

final class SwirlUser {
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
}

struct SwirlUserValue {
    static let uid = "uid"
    static let username = "username"
    static let biography = "biography"
    static let postUIDs = "postUIDs"
    static let followerUIDs = "followerUIDs"
    static let followingUIDs = "followingUIDs"
    static let photoURL = "photoURL"
}

extension SwirlUser: ModelConvertable {
    static func toJSON(from value: SwirlUser) -> JSON {
        return [
            SwirlUserValue.uid: value.uid,
            SwirlUserValue.username: value.username,
            SwirlUserValue.biography: value.biography,
            SwirlUserValue.postUIDs: value.postUIDs,
            SwirlUserValue.followerUIDs: value.followerUIDs,
            SwirlUserValue.followingUIDs: value.followingUIDs,
            SwirlUserValue.photoURL: value.photoURL as Any
        ]
    }

    static func toValue(from json: JSON?) -> SwirlUser? {
        guard let json = json,
            let uid = json[SwirlUserValue.uid] as? String,
            let username = json[SwirlUserValue.username] as? String,
            let biography = json[SwirlUserValue.biography] as? String
        else { return nil }

        let postUIDs = json[SwirlUserValue.postUIDs] as? [String] ?? []
        let followerUIDs = json[SwirlUserValue.followerUIDs] as? [String] ?? []
        let followingUIDs = json[SwirlUserValue.followingUIDs] as? [String] ?? []
        let photoURL = json[SwirlUserValue.photoURL] as? String

        return SwirlUser(uid: uid, username: username, biography: biography, postUIDs: postUIDs,
                         followerUIDs: followerUIDs, followingUIDs: followingUIDs, photoURL: photoURL)
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
