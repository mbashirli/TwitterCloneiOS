//
//  TweetFilterViewModel.swift
//  TwitterClone
//
//  Created by Murad Bashirli on 16.01.23.
//

enum TweetFilterViewModel: Int, CaseIterable {
    case tweets
    case replies
    case likes
    
    var title: String {
        switch self {
        case .tweets: return "Tweets"
        case .replies: return "Replies"
        case .likes: return "Likes"
        }
    }
}


