//
//  Tweet.swift
//  TwitterClone
//
//  Created by Murad Bashirli on 03.02.23.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct Tweet: Identifiable, Decodable {
    @DocumentID var id: String?
    let caption: String
    let timestamp: Timestamp
    let uid: String
    var likes: Int
    
    var user: User?
    var didLike: Bool? = false
}
