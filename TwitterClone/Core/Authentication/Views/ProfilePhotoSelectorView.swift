//
//  ProfilePhotoSelectorView.swift
//  TwitterClone
//
//  Created by Murad Bashirli on 23.01.23.
//

import SwiftUI


struct ProfilePhotoSelectorView: View {
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        VStack{
            AuthHeaderView(title1: "Setup account.", title2: "Add a profile photo.")
            
            Button {
                showImagePicker.toggle()
            } label: {
                ZStack{
                    if let profileImage = profileImage {
                        profileImage
                            .resizable()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                    }
                    else {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 200, height: 240)
                            .overlay(
                                Circle()
                                    .stroke(Color(.systemBlue), lineWidth: 5)
                            )
                        Image("add_photo")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color(.systemBlue))
                            .frame(width: 100, height: 120)
                    }
                    
                }
                .padding(.top, 50)
                .sheet(isPresented: $showImagePicker, onDismiss: loadImage)
                {
                    ImagePicker(selectedImage: $selectedImage)
                }
                
            }
            
            if let selectedImage = selectedImage {
                Button {
                    viewModel.uploadProfileImage(selectedImage)
                } label:
                {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(Color(.systemBlue))
                        .clipShape(Capsule())
                        .padding()
                    
                }
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y:0)
            }
            Spacer()
            
        }
        .ignoresSafeArea()
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else {return}
        profileImage = Image(uiImage: selectedImage)
    }
}

struct ProfilePhotoSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoSelectorView()
    }
}
