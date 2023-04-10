//
//  SiginWithPasswordView.swift
//  Zenion
//
//  Created by macbook on 05.04.23.
//

import SwiftUI

struct SiginWithPasswordView: View {
    @State private var userName =  String()
    @State private var password = String()
    @State private var isResetPasswordLinkActive = false
    
    var body: some View {
        ZStack{
            Color.black
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
                        .frame(height:15)
                        .padding(20)
                        .foregroundColor(.white)
                        .tint(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .stroke(Color.purple, lineWidth: 2)
                        )
                        .padding([.leading, .trailing], 24)
                    
                    Button {
                        //action
                        isResetPasswordLinkActive = true
                    } label: {
                        Spacer()
                        Text("Forgot Password?")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .bold,design: .rounded))
                            .padding([.trailing],40)
                    }
                    .sheet(isPresented: $isResetPasswordLinkActive) {
                        ResetPasswordView()
                    }
                    Divider()
                    NavigationLink(destination: TabBarView()){
                        CustomRegisterButtom(imageName: "", text: "Sign in", color: .purple, imageWidth: 0, imageHeight: 0,action: {
                            print("hello")
                        })
                        
                    }
                    
                }
                Spacer()
            }
        }
    }
}

struct SiginWithPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        SiginWithPasswordView()
    }
}
