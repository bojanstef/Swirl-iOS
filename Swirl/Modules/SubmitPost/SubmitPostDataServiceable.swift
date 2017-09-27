//
//  SubmitPostDataServiceable.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/21/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import Foundation

protocol SubmitPostDataServiceable {
    func submitPost(_ videoURL: URL, title: String, completion: @escaping ((Error?) -> Void))
}
