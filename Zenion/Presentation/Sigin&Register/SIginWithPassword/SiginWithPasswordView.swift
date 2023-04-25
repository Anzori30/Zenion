//
//  SiginWithPasswordView.swift
//  Zenion
//
//  Created by macbook on 05.04.23.
//

import SwiftUI

struct SignInWithPasswordView: View {
    @State private var userName = ""
    @State private var password = ""
    @State private var isResetPasswordLinkActive = false
    @State private var isLogin = false
    @StateObject var viewModel = SignInViewModel()
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Image("logo")
                    .resizable()
                    .frame(width: 40, height: 40)
                
                Text("Z E N I O N")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Divider()
                
                VStack {
                    TextField("", text: $userName, prompt: Text("UserName").foregroundColor(.gray))
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
                    
                    SecureField("", text: $password, prompt: Text("Password").foregroundColor(.gray))
                        .frame(height: 15)
                        .padding(20)
                        .foregroundColor(.white)
                        .tint(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .stroke(Color.purple, lineWidth: 2)
                        )
                        .padding([.leading, .trailing], 24)
                    
                    Button(action: {
                        isResetPasswordLinkActive = true
                    }) {
                        Spacer()
                        
                        Text("Forgot Password?")
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .padding([.trailing], 40)
                    }
                    .sheet(isPresented: $isResetPasswordLinkActive) {
                        ResetPasswordView()
                    }
                    
                    Divider()
                    NavigationLink( destination: TabBarView(),isActive: $viewModel.isSignedIn) {
                        CustomButton(text: "Sign in", color: .purple, Width: 300, Height: 50) {
                            viewModel.signIn(withEmail: userName, password: password)
                        }
                    }
                    .alert(viewModel.errors, isPresented: $viewModel.alert) {
                        Button("OK", role: .cancel) { }
                    }
                }
                Spacer()
                PrivacypPolicyView()
            }
            .overlay(
                HStack{
                    if viewModel.ActivityIndicator {
                       ActivityIndicator(isAnimating: true)
                        .foregroundColor(.red)
                        .frame(width: 80)
                   }
            })
        }
    }
}

struct SignInWithPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithPasswordView()
    }
}




