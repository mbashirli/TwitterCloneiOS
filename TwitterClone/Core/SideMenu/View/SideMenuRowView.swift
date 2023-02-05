//
//  SideMenuRowView.swift
//  TwitterClone
//
//  Created by Murad Bashirli on 16.01.23.
//

import SwiftUI

struct SideMenuRowView: View {
    let viewModel: SideMenuViewModel
    var body: some View {
        HStack (spacing: 16) {
            Image(systemName: viewModel.imageName)
                .font(.headline)
                .foregroundColor(.gray)
            
            Text(viewModel.title)
                .font(.subheadline)
                .foregroundColor(.black)
            Spacer()
        }
        .frame(height: 40)
        .padding(.horizontal)
    }
}

struct SideMenuRowView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuRowView(viewModel: .profile)
    }
}
