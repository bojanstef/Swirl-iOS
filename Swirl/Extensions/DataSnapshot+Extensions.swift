//
//  DataSnapshot+Extensions.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/15/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import Firebase

extension DataSnapshot {
    var toJSON: JSON? {
        return self.value as? JSON
    }
}
