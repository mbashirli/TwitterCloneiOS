//
//  Profile.swift
//  TwitterClone
//
//  Created by Murad Bashirli on 29.01.23.
//

import SwiftUI
import Kingfisher

struct Profile: View {
    let user: User
    @State private var selectedFilter: TweetFilterViewModel = .tweets
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var authViewModel: AuthViewModel
    @Namespace var animation
    
    init (user: User)
    {
        self.user = user
    }
    
    var body: some View {
        VStack(alignment: .leading){
            headerView
            
            actionButtons
            
            userInfoDetails
            
            tweetFilterBar
            
            tweetsView
            
            Spacer()
            
        }
        .toolbar(.hidden)
    }
}

extension Profile{
    var headerView: some View {
        ZStack(alignment: .bottomLeading){
            Color(.systemBlue)
                .ignoresSafeArea()
            VStack {
                Button{
                    mode.wrappedValue.dismiss()
                }label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 20, height: 16)
                        .foregroundColor(.white)
                        .offset(x: 16, y: -4)
                }
                
                KFImage(URL(string: user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 72, height: 72)
                    .offset(x: 16, y: 24)
            }
        }
        .frame(height: 100)
    }
    
    var actionButtons: some View {
        HStack(spacing: 12) {
            Spacer()
            Image(systemName: "bell.badge")
                .font(.title3)
                .padding(6)
                .overlay(Circle().stroke(Color.gray, lineWidth: 0.75))
            Button{
                
            }label:
            {
                Text("Edit Profile")
                    .font(.subheadline).bold()
                    .frame(width: 120, height: 32)
                    .foregroundColor(Color.black)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0.75))
            }
        }.padding(.trailing)
    }
    
    var userInfoDetails: some View {
        VStack (alignment: .leading, spacing: 4){
           
                HStack {
                    Text(user.fullName)
                        .font(.title2).bold()
                    Image.init(systemName: "checkmark.seal.fill")
                        .foregroundColor(Color(.systemBlue))
                }
                Text("@\(user.username)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text("Live long and prosper!")
                    .font(.subheadline)
                    .padding(.vertical)
                
                HStack (spacing: 32){
                    HStack{
                        Image(systemName: "mappin.and.ellipse")
                        Text("Baku, Azerbaijan")
                    }
                    
                    HStack{
                        Image(systemName: "link")
                        Text("www.murosh.gov.az")
                    }
                }
                .font(.caption)
                .foregroundColor(.gray)
                
                UserStatsView()
                .padding(.vertical)
            
        }.padding(.horizontal)
    }
    
    var tweetFilterBar: some View {
        HStack {
            ForEach(TweetFilterViewModel.allCases, id: \.rawValue){ item in
                VStack {
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == item ? .semibold : .regular)
                        .foregroundColor(selectedFilter == item ? .black : .gray)
                    
                    if selectedFilter == item {
                        Capsule()
                            .foregroundColor(Color(.systemBlue))
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    }
                    else
                    {
                        Capsule()
                            .foregroundColor(Color(.clear))
                            .frame(height: 3)
                    }
                }.onTapGesture {
                    withAnimation(.easeInOut)
                    {
                        self.selectedFilter = item
                    }
                }
            }
            
        }
        .overlay(Divider().offset(x: 0, y:16))
        
    }
    
    var tweetsView: some View {
        ScrollView{
            LazyVStack{
                ForEach(0 ... 9, id: \.self) { _ in
                    TweetRowView()
                    
                }
            }
        }
        
    }
}



