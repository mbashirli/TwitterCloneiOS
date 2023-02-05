//
//  TweetRowView.swift
//  TwitterClone
//
//  Created by Murad Bashirli on 16.01.23.
//

import SwiftUI
import Kingfisher

struct TweetRowView: View {
    @ObservedObject var viewModel: TweetRowViewModel
    
    init (tweet: Tweet)
    {
        self.viewModel = TweetRowViewModel(tweet: tweet)
    }
    
    var body: some View {
        VStack (alignment:.leading){
            HStack (alignment: .top, spacing: 12 ){
                // profile picture and its properties
                if let user = viewModel.tweet.user {
                    NavigationLink {
                        ProfileView(user: user)
                    } label: {
                        KFImage(URL(string: user.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 56, height: 56)
                            .clipShape(Circle())
                        
                    }
                // user info & tweet caption
                VStack (alignment: .leading, spacing: 4){
                    
                        HStack{
                            Text(user.fullName)
                                .font(.subheadline).bold()
                            Text("@\(user.username)")
                                .font(.caption)
                                .foregroundColor(Color(.gray))
                            Text("1w")
                                .font(.caption)
                                .foregroundColor(Color(.gray))
                        }
                    Text(viewModel.tweet.caption)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                    }
                }
            }
            // action buttons
            
            HStack() {
                
                Button {
                    
                } label:{
                    Image(systemName: "bubble.left")
                        .font(.subheadline)
                    
                }
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "arrow.2.squarepath")
                        .font(.subheadline)
                }
                Spacer()
                Button {
                    viewModel.tweet.didLike ?? false ? viewModel.unlikeTweet() : viewModel.likeTweet()
                }label: {
                    Image(systemName: viewModel.tweet.didLike ?? false ? "heart.fill" : "heart")
                        .font(.subheadline)
                        .foregroundColor(viewModel.tweet.didLike ?? false ? Color(.systemRed) : Color(.gray))
                }
                Spacer()
                Button {
                    
                }label: {
                    Image(systemName: "bookmark")
                        .font(.subheadline)
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 5)
            
            .foregroundColor(.gray)
            Divider()

        }
        .padding()
    }
    
}

