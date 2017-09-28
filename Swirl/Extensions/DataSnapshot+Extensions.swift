//
//  DataSnapshot+Extensions.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/15/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import Firebase

extension DataSnapshot {
    var data: Data? {
        guard let json = self.value as? [String: Any] else { return nil }
        return try? JSONSerialization.data(withJSONObject: json, options: [])
    }
}
