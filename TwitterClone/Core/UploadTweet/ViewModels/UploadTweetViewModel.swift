//
//  UploadTweetViewModel.swift
//  TwitterClone
//
//  Created by Murad Bashirli on 03.02.23.
//

import Foundation


class UploadTweetViewModel: ObservableObject {
    @Published var didUploadTweet = false
    let service = TweetService()
    
    func uploadTweet(withCaption caption: String) {
        service.uploadTweet(caption: caption) { success in
            if success {
                self.didUploadTweet = true
            } else
            {
                // show error message to user..
            }
        }
    }
}
