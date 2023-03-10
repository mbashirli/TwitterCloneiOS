//
//  NewTweetView.swift
//  TwitterClone
//
//  Created by Murad Bashirli on 18.01.23.
//

import SwiftUI
import Kingfisher

struct NewTweetView: View {
    @State private var caption = ""
    @Environment(\.presentationMode) var presentationMode // for the cancel button
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var viewModel = UploadTweetViewModel()
    var body: some View {
        VStack(alignment: .leading){
            HStack (){
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label:
                {
                    Text("Cancel")
                        .foregroundColor(Color(.systemBlue))
                }
                Spacer()
                Button {
                    viewModel.uploadTweet(withCaption: caption)
                    
                    
                    
                    //presentationMode.wrappedValue.dismiss()
                } label:
                {
                    Text("Tweet")
                        .bold()
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color(.systemBlue))
                        .foregroundColor(Color(.white))
                        .clipShape(Capsule())
                    
                }
            
            }
            .padding()
          
            
            HStack(alignment: .top) {
                if let user = authViewModel.currentUser {
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 64, height: 64)
                        .padding()
                }
                    
                TextArea("What's happening?", text: $caption)
                    

                    
            }
            
         Spacer()
        }
        .onReceive(viewModel.$didUploadTweet) { success in
            if success {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct NewTweetView_Previews: PreviewProvider {
    static var previews: some View {
        NewTweetView()
    }
}
