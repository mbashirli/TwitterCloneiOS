//
//  userRowView.swift
//  TwitterClone
//
//  Created by Murad Bashirli on 16.01.23.
//

import SwiftUI
import Kingfisher

struct UserRowView: View {
    let user: User
    var body: some View {
    
        HStack (spacing: 12) {
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .clipShape(Circle())
                .scaledToFill()
                .frame(width: 56, height: 56)
            VStack (alignment: .leading ) {
                Text(user.username)
                    .bold()
                    .font(.subheadline)
                    .foregroundColor(.black)
                    
                Text(user.fullName)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 2)
    }
}

//struct UserRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserRowView()
//    }
//}
