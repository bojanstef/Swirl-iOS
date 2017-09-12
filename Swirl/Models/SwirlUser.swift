//
//  SwirlUser.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/11/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import Foundation

struct SwirlUser {
    let uid: String
}

struct SwirlUserValue {
    static let uid = "uid"
}

extension SwirlUser: ModelConvertable {
    static func toJSON(from value: SwirlUser) -> JSON {
        return [SwirlUserValue.uid: value.uid]
    }

    static func toValue(from json: JSON?) -> SwirlUser? {
        guard let json = json, let uid = json[SwirlUserValue.uid] as? String else { return nil }
        return SwirlUser(uid: uid)
    }
}
