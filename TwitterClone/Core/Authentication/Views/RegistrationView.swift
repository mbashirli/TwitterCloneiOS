//
//  RegistrationView.swift
//  TwitterClone
//
//  Created by Murad Bashirli on 19.01.23.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var username = ""
    @State private var fullName = ""
    @State private var password = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        NavigationView {
            VStack{
                
                
                AuthHeaderView(title1: "Get Started.", title2: "Create your account.")
                VStack (spacing: 40){
                    CustomInputField(imageName: "envelope", placeholderText: "Email", text: $email)
                    
                    CustomInputField(imageName: "person", placeholderText: "Username", text: $username)
                    
                    CustomInputField(imageName: "person", placeholderText: "Full Name", text: $fullName)
                    
                    CustomInputField(imageName: "lock", placeholderText: "Password", isSecureField: true, text: $password)
                }
                .padding(.horizontal, 32)
                .padding(.top, 44)
             
                
                    NavigationLink (destination: ProfilePhotoSelectorView()){
                        Text("Sign Up")
                            .font(.headline)
                            .frame(width: 300, height: 50)
                            .background(Color(.systemBlue))
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .padding()
                    }
                    .simultaneousGesture(TapGesture().onEnded{
                        viewModel.register(
                            withEmail: email,
                            password: password,
                            fullName: fullName,
                            username: username)
                    })
                    .toolbar(.hidden)
                    .navigationBarBackButtonHidden(true)
                
                
                
                Spacer()
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                    
                }label: {
                    HStack {
                        Text("Already have an account?")
                        Text("Sign In")
                            .fontWeight(.semibold)
                    }
                }
                .foregroundColor(Color(.systemBlue))
                .font(.body)
                .padding(.vertical)
                
                
            }
            .ignoresSafeArea()
        }
    }
}


struct ProfilePhotoView: View {
    var body: some View {
        VStack{
            Button {
                
            }
            label :{
                Text("Enter")
            }
        }
    }
}


struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
