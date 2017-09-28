//
//  Post.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/14/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import IGListKit

final class Post: Codable {
    let uid: String
    let url: String
    let ownerUID: String
    let title: String
    let loops: Int
    let likes: Int

    init(uid: String, url: String, ownerUID: String, title: String,
         loops: Int = 0, likes: Int = 0) {

        self.uid = uid
        self.url = url
        self.ownerUID = ownerUID
        self.title = title
        self.loops = loops
        self.likes = likes
    }

    required init(from decoder: Decoder) throws {
        guard let uid = container.deco
    }

    func encode() throws -> [String: Any]? {
        let jsonData = try JSONEncoder().encode(self)
        return try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
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
