//
//  FeedView.swift
//  TwitterClone
//
//  Created by Murad Bashirli on 16.01.23.
//

import SwiftUI

struct FeedView: View {
    @State private var showNewTweetView = false
    @ObservedObject var viewModel = FeedViewModel()
    var body: some View {
        ZStack (alignment: .bottomTrailing){
            ScrollView {
                LazyVStack{
                    ForEach(viewModel.tweets) { tweet in
                        TweetRowView(tweet: tweet)
                    }
                }
            }
            Button {
                showNewTweetView.toggle()
            } label  : {
                Image(systemName: "square.and.pencil")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 30, height: 30)
                    .padding()
            }
            .background(Color(.systemBlue))
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
            .fullScreenCover(isPresented: $showNewTweetView)
            {
                NewTweetView()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
