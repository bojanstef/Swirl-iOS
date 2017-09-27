//
//  Post.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/14/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import IGListKit

final class Post {
    let uid: String
    let url: String
    let ownerUID: String
    let title: String
    let loops: Int
    let likes: Int

    init(uid: String, url: String, ownerUID: String, title: String, loops: Int = 0, likes: Int = 0) {
        self.uid = uid
        self.url = url
        self.ownerUID = ownerUID
        self.title = title
        self.loops = loops
        self.likes = likes
    }
}

struct PostValue {
    static let uid = "uid"
    static let url = "url"
    static let ownerUID = "ownerUID"
    static let title = "title"
    static let loops = "loops"
    static let likes = "likes"
}

extension Post: ModelConvertable {
    static func toJSON(from value: Post) -> JSON {
        return [
            PostValue.uid: value.uid,
            PostValue.url: value.url,
            PostValue.ownerUID: value.ownerUID,
            PostValue.title: value.title,
            PostValue.loops: value.loops,
            PostValue.likes: value.likes
        ]
    }

    static func toValue(from json: JSON?) -> Post? {
        guard let json = json,
            let uid = json[PostValue.uid] as? String,
            let url = json[PostValue.url] as? String,
            let ownerUID = json[PostValue.ownerUID] as? String,
            let title = json[PostValue.title] as? String,
            let loops = json[PostValue.loops] as? Int,
            let likes = json[PostValue.likes] as? Int
            else { return nil }

        return Post(uid: uid, url: url, ownerUID: ownerUID, title: title, loops: loops, likes: likes)
    }
}

extension Post: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return NSString(string: uid)
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let post = object as? Post else { return false }
        return self == post
    }
}

extension Post: Equatable {
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.uid == rhs.uid
            && lhs.url == rhs.url
            && lhs.ownerUID == rhs.ownerUID
            && lhs.title == rhs.title
            && lhs.loops == rhs.loops
            && lhs.likes == rhs.likes
    }
}
