//
//  User.swift
//  TwitterClone
//
//  Created by Murad Bashirli on 28.01.23.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let fullName: String
    let profileImageUrl: String
    let email: String
}
