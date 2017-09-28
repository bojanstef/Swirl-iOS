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
    case noDownloadURL
    case noPosts
}

private enum ContentType: String {
    case video = "video/mp4"
}

private struct Constants {
    static let readPermissions = ["public_profile", "email", "user_friends"]
}

private struct DatabaseNodes {
    static let users = "users"
    static let posts = "posts"
}

private struct StorageNodes {
    static let videos = "videos"
}

final class DataService {
    fileprivate let databaseReference: DatabaseReference
    fileprivate let storageReference: StorageReference

    static var defaultService: DataService {
        let databaseReference = Database.database().reference()
        let storageReference = Storage.storage().reference()
        return DataService(databaseReference: databaseReference, storageReference: storageReference)
    }

    private init(databaseReference: DatabaseReference, storageReference: StorageReference) {
        self.databaseReference = databaseReference
        self.storageReference = storageReference
    }
}

/**** Common Methods ****/
extension DataService {
    func getCurrentUser(completion: @escaping ((SwirlUser?, Error?) -> Void)) {
        guard let userUID = Auth.auth().currentUser?.uid else { completion(nil, APIError.noUser); return }
        let ref = databaseReference.child(DatabaseNodes.users).child(userUID)
        ref.observeSingleEvent(of: .value, with: { snapshot in
            let swirlUser = SwirlUser.toValue(from: snapshot.toJSON)
            completion(swirlUser, nil); return
        })
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
    func getPosts(for swirlUser: SwirlUser, completion: @escaping (([Post], Error?) -> Void)) {
        let ref = databaseReference.child(DatabaseNodes.posts).child(swirlUser.uid)
        ref.observeSingleEvent(of: .value, with: { snapshots in
            let posts: [Post] = snapshots.children.allObjects.flatMap { snapshot in
                guard let snapshot = snapshot as? DataSnapshot else { return nil }
                return Post.toValue(from: snapshot.toJSON)
            }
            completion(posts, nil)
        })
    }
}

extension DataService: SubmitPostDataServiceable {
    func submitPost(_ videoURL: URL, title: String, completion: @escaping ((Error?) -> Void)) {
        guard let userUID = Auth.auth().currentUser?.uid else { completion(APIError.noUser); return }
        let postUID = UUID().uuidString
        let ref = storageReference.child(StorageNodes.videos).child(postUID)
        ref.putFile(from: videoURL, metadata: createMetadata(contentType: .video)) { [weak self] metadata, error in
            if let error = error {
                completion(error)
            } else {
                guard let url = metadata?.downloadURL()?.absoluteString else {
                    completion(APIError.noDownloadURL)
                    return
                }
                let post = Post(uid: postUID, url: url, ownerUID: userUID, title: title)
                self?.savePost(post, completion: completion)
            }
        }
    }
}

extension DataService: CreatePostDataServiceable {}
extension DataService: MainTabBarDataServiceable {}

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

    func createMetadata(contentType: ContentType) -> StorageMetadata {
        let metadata = StorageMetadata()
        metadata.contentType = contentType.rawValue
        return metadata
    }

    func savePost(_ post: Post, completion: @escaping ((Error?) -> Void)) {
        let ref = databaseReference.child(DatabaseNodes.posts).child(post.ownerUID).child(post.uid)
        ref.setValue(Post.toJSON(from: post)) { [weak self] error, _ in
            if let error = error {
                completion(error)
            } else {
                self?.appendToUserPosts(post.uid, ownerUID: post.ownerUID, completion: completion)
            }
        }
    }

    func appendToUserPosts(_ postUID: String, ownerUID: String, completion: @escaping ((Error?) -> Void)) {
        getCurrentUser { [weak self] user, error in
            guard let this = self, let user = user else { completion(APIError.noUser); return }
            if let error = error {
                completion(error)
            } else {
                let postUIDs = user.postUIDs + [postUID]
                let ref = this.databaseReference.child(DatabaseNodes.users).child(user.uid)
                ref.updateChildValues([SwirlUserValue.postUIDs: postUIDs]) { updateError, _ in
                    completion(updateError)
                }
            }
        }
    }
}
