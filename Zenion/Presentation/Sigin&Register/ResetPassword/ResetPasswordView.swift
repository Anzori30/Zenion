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
    @State private var password = String()
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
                    
                    CustomRegisterButtom(imageName: "", text: "Sign in", color: .purple, imageWidth: 0, imageHeight: 0,action: {
                        print("hello")
                        presentationMode.wrappedValue.dismiss() // Dismiss the current
                    })
                }
                Spacer()
            }
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
