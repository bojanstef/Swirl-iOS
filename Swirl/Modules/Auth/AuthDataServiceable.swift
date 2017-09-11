//
//  AuthDataServiceable.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/9/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import Foundation

protocol AuthDataServiceable {
    var isAuthenticated: Bool { get }
    func requestLogin(with viewController: AuthViewController, completion: @escaping ((Bool, Error?) -> Void))
}
