//
//  SideMenuView.swift
//  TwitterClone
//
//  Created by Murad Bashirli on 16.01.23.
//

import SwiftUI
import Kingfisher

struct SideMenuView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        
        if let user = authViewModel.currentUser {
            VStack (alignment: .leading, spacing: 32) {
                VStack (alignment: .leading){
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 48, height: 48)
                    
                    
                    VStack (alignment: .leading, spacing:  2){
                        Text(user.fullName)
                            .font(.headline)
                            .bold()
                        Text("@\(user.username)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    UserStatsView()
                        .padding(.vertical)
                }.padding(.leading)
                
                ForEach(SideMenuViewModel.allCases, id: \.rawValue) { option in
                    if option == .profile {
                        NavigationLink {
                            ProfileView(user: user)
                        } label: {
                            SideMenuRowView(viewModel: option)
                        }
                    }
                    else if option == .logout {
                        Button {
                            authViewModel.signOut()
                        } label: {
                            SideMenuRowView(viewModel: option)
                        }
                    }
                    else
                    {
                        SideMenuRowView(viewModel: option)
                    }
                    
                }
                Spacer()
                
            }
        }
    }
}
struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}


