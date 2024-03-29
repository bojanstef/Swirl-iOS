//
//  ProfileDataServiceable.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/11/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import Foundation

protocol ProfileDataServiceable {
    func getCurrentUser(completion: @escaping ((SwirlUser?, Error?) -> Void))
    func getPosts(for swirlUser: SwirlUser, completion: @escaping (([Post], Error?) -> Void))
}
