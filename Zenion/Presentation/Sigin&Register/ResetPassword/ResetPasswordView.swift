//
//  ResetPasswordView.swift
//  Zenion
//
//  Created by macbook on 05.04.23.
//

import SwiftUI

struct ResetPasswordView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var email =  String()
    @StateObject var viewModel = ResetPasswordModelView()
    var body: some View {
        ZStack{
            Color("Dark")
            .ignoresSafeArea()
            VStack{
                Spacer()
                Image("logo")
                    .resizable()
                    .frame(width: 40,height: 40)
                Text("Z E N I O N")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold,design: .rounded))
                Divider()
                VStack{
                 Divider()
                    TextField("", text: $email, prompt: Text("Email").foregroundColor(.gray))
                        .frame(height: 15)
                        .padding(20)
                        .foregroundColor(.white)
                        .tint(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .stroke(Color.purple, lineWidth: 2)
                        )
                        .padding([.leading, .trailing], 24)
                   Divider()
                    CustomButton(text: "Sign in", color: .purple, Width: 300, Height: 50, action: {
                        viewModel.signIn(withEmail: email)
                    })
                    .alert(viewModel.info, isPresented: $viewModel.alert) {
                        Button("OK", role: .cancel) {
                            if viewModel.isSignedIn{
                                email = ""
                            }
                        }
                    }
                   
                }
                Spacer()
               PrivacypPolicyView()
            }
        }
        .overlay(
            HStack{
                if viewModel.activityIndicator {
                   ActivityIndicator(isAnimating: true)
                    .foregroundColor(.red)
                    .frame(width: 80)
               }
        })
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
