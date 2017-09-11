//
//  ModelConvertable.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/11/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

protocol ModelConvertable {
    associatedtype T // swiftlint:disable:this type_name
    static func toValue(from json: JSON?) -> T?
    static func toJSON(from value: T) -> JSON
}
