//
//  UserService.swift
//  TwitterClone
//
//  Created by Murad Bashirli on 28.01.23.
//

import Firebase
import FirebaseFirestoreSwift

struct UserService {
    
    
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void)
    {
        print("DEBUG: Fetching user")
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument{ snapshot, _ in
                guard let snapshot = snapshot else {
                    print("Snapshot failed")
                    return
                }
                
                guard let user = try? snapshot.data(as: User.self) else {
                    print("User failed")
                    return
                }
                
                
                //print("DEBUG: User succesfully fetched")
                print("Username: \(user.username)")
                completion(user)
            }
        
    }
    
    func fetchUsers(completion: @escaping([User]) -> Void)
    {
        var users = [User]()
        Firestore.firestore().collection("users")
            .getDocuments  {snapshot, _ in
                guard let documents = snapshot?.documents else {return}
                
                
                documents.forEach { document in
                    guard let user = try? document.data(as: User.self) else {return}
                    users.append(user)
                }
                
                completion(users)
                
            }
        
    }
}
