//
//  DataService.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/9/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import Foundation
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

private enum APIError: Error {
    case noUser
}

private struct Constants {
    static let readPermissions = ["public_profile", "email", "user_friends"]
}

private struct DatabaseNodes {
    static let users = "users"
    static let posts = "posts"
}

final class DataService {
    fileprivate let databaseReference: DatabaseReference

    static var defaultService: DataService {
        let databaseReference = Database.database().reference()
        return DataService(databaseReference: databaseReference)
    }

    private init(databaseReference: DatabaseReference) {
        self.databaseReference = databaseReference
    }
}

extension DataService: AuthDataServiceable {
    var isAuthenticated: Bool {
        return Auth.auth().currentUser != nil
    }

    func requestLogin(with viewController: AuthViewController, completion: @escaping ((Bool, Error?) -> Void)) {
        FBSDKLoginManager().logIn(withReadPermissions: Constants.readPermissions,
                                  from: viewController) { [weak self] result, error in

            guard let result = result, error == nil else { completion(false, error); return }
            if result.isCancelled {
                completion(false, nil); return
            } else {
                let credential = FacebookAuthProvider
                    .credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self?.authenticateWithFirebase(credential, completion: completion)
            }
        }
    }
}

extension DataService: ProfileDataServiceable {
    func getCurrentUser(completion: @escaping ((SwirlUser?, Error?) -> Void)) {
        guard let userID = Auth.auth().currentUser?.uid else { completion(nil, APIError.noUser); return }
        let ref = databaseReference.child(DatabaseNodes.users).child(userID)
        ref.observeSingleEvent(of: .value, with: { snapshot in
            let swirlUser = SwirlUser.toValue(from: snapshot.toJSON)
            completion(swirlUser, nil); return
        })
    }

    // ISSUE: - https://github.com/bojanstef/Swirl-iOS/issues/6
    func observePosts(for swirlUser: SwirlUser, completion: @escaping (([Post], Error?) -> Void)) {
        let ref = databaseReference.child(DatabaseNodes.posts).child(swirlUser.uid)
        ref.observeSingleEvent(of: .value, with: { snapshot in
            guard let dict = snapshot.toJSON else { completion([], APIError.noUser); return }
            print(dict)
            completion([], nil)
        })
    }
}

fileprivate extension DataService {
    func authenticateWithFirebase(_ credential: AuthCredential, completion: @escaping ((Bool, Error?) -> Void)) {
        Auth.auth().signIn(with: credential) { [weak self] user, error in
            guard let user = user, error == nil else { completion(false, error); return }
            self?.checkIfNewUser(user, completion: completion)
        }
    }

    func checkIfNewUser(_ user: User, completion: @escaping ((Bool, Error?) -> Void)) {
        let ref = databaseReference.child(DatabaseNodes.users).child(user.uid)
        ref.observeSingleEvent(of: .value, with: { [weak self] snapshot in
            if snapshot.exists() {
                completion(true, nil); return
            } else {
                self?.saveSwirlUser(user, to: ref, completion: completion)
            }
        })
    }

    func saveSwirlUser(_ user: User, to ref: DatabaseReference, completion: @escaping ((Bool, Error?) -> Void)) {
        let transformedDisplayName = user.displayName?.removingWhitespaces.lowercased()
        let username = transformedDisplayName ?? String.randomAnimalUnique
        let swirlUser = SwirlUser(uid: user.uid, username: username)
        ref.setValue(SwirlUser.toJSON(from: swirlUser)) { error, _ in
            completion(error == nil, error); return
        }
    }
}
