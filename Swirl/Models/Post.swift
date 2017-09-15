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
    let owner: String
    let views: Int
    let likes: Int

    init(uid: String, url: String, owner: String, views: Int, likes: Int) {
        self.uid = uid
        self.url = url
        self.owner = owner
        self.views = views
        self.likes = likes
    }
}

struct PostValue {
    static let uid = "uid"
    static let url = "url"
    static let owner = "owner"
    static let views = "views"
    static let likes = "likes"
}

extension Post: ModelConvertable {
    static func toJSON(from value: Post) -> JSON {
        return [
            PostValue.uid: value.uid,
            PostValue.url: value.url,
            PostValue.owner: value.owner,
            PostValue.views: value.views,
            PostValue.likes: value.likes
        ]
    }

    static func toValue(from json: JSON?) -> Post? {
        guard let json = json,
            let uid = json[PostValue.uid] as? String,
            let url = json[PostValue.url] as? String,
            let owner = json[PostValue.owner] as? String,
            let views = json[PostValue.views] as? Int,
            let likes = json[PostValue.likes] as? Int
            else { return nil }

        return Post(uid: uid, url: url, owner: owner, views: views, likes: likes)
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
            && lhs.owner == rhs.owner
            && lhs.views == rhs.views
            && lhs.likes == rhs.likes
    }
}
