//
//  TweetService.swift
//  TwitterClone
//
//  Created by Murad Bashirli on 02.02.23.
//

import Foundation
import Firebase

struct TweetService{
    
    
    func uploadTweet(caption: String, completion: @escaping(Bool) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        
        let data = [
            "uid": uid,
            "caption": caption,
            "likes": 0,
            "timestamp": Timestamp(date: Date())] as [String: Any]
        
        Firestore.firestore().collection("tweets").document()
            .setData(data) { error in
                if let error = error {
                    print("DEBUG: Failed to upload tweet with error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                completion(true)
                print("DEBUG: Did upload tweet...")
                
            }
        
    }
    
    func fetchTweets(completion: @escaping([Tweet]) -> Void) {
        var Tweets = [Tweet]()
        Firestore.firestore().collection("tweets")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else {return}
            
            documents.forEach { doc in
                guard let data = try? doc.data(as: Tweet.self) else {return}
                Tweets.append(data)
            }
            
            completion(Tweets)
        }
    }
    
    func fetchTweets(forUid uid: String, completion: @escaping([Tweet]) -> Void)
    {
        var Tweets = [Tweet]()
        Firestore.firestore()
            .collection("tweets")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else {return}
                
                documents.forEach { doc in
                    guard let data = try? doc.data(as: Tweet.self) else {return}
                    Tweets.append(data)
                }
                completion(Tweets.sorted(by: {$0.timestamp.dateValue() > $1.timestamp.dateValue()}))
            }
    }
    
    func likeTweet(tweet: Tweet, completion: @escaping() -> Void)
    {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let tweetID = tweet.id else {return}
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        Firestore.firestore()
            .collection("tweets")
            .document(tweetID)
            .updateData(["likes": tweet.likes + 1]) { _ in
                userLikesRef.document(tweetID).setData([:]) { _ in
                    completion()
                }
            }
        
        
    }
    
    
    func checkIfUserLikedTweet(_ tweet: Tweet, completion: @escaping(Bool) -> Void)
    {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let tweetID = tweet.id else {return}
        Firestore.firestore()
            .collection("users")
            .document(uid).collection("user-likes")
            .document(tweetID).getDocument { snapshot, _ in
                guard let snapshot = snapshot else {return}
                completion(snapshot.exists)
            }
            
    }
    
    func unlikeTweet(_ tweet: Tweet, completion: @escaping() ->Void)
    {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let tweetID = tweet.id else {return}
        guard tweet.likes >= 0 else {return}
        
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        Firestore.firestore()
            .collection("users")
            .document(uid).collection("tweets")
            .document(tweetID)
            .updateData(["likes": tweet.likes - 1]) { _ in
                userLikesRef.document(tweetID).delete { _ in
                    completion()
                }
            }
    }
}
