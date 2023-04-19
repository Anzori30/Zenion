//
//  DestinationStart.swift
//  Zenion
//
//  Created by macbook on 10.04.23.
//

import SwiftUI

struct DestinationStart: View{
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    Spacer()
                    Image("boyimage")
                        .resizable()
                        .frame(width: 220, height: 250)
                    Text("Sign in to Zenion")
                        .font(.system(size: 25, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    Spacer()
                    VStack {
                        CustomRegisterButton(imageName:"Ios-icon", text: "Continue with Apple", color: .clear, imageWidth: 20, imageHeight: 20,destination: SignInWithPasswordView(),navigate: true){ }
                        Divider()
                        CustomRegisterButton(imageName:"google-icon", text:"Continue with Google", color: .clear, imageWidth: 20, imageHeight: 20,destination: SignInWithPasswordView(),navigate: true){ }
                        Divider()
                        HStack {
                            Text("")
                                .frame(width: 120, height: 2)
                                .border(Color.red, width: 1)
                            Text("or")
                                .foregroundColor(.white)
                            Text("")
                                .frame(width: 120, height: 2)
                                .border(Color.red, width: 1)
                        }
                        Divider()
                            CustomRegisterButton(imageName:"", text:"Sign in with Password" , color: .purple, imageWidth: 0, imageHeight:0,destination: SignInWithPasswordView(),navigate: true) {
                            }
                        Divider()
                        CreatAccount()
                    }
                    Spacer()
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct DestinationStartView_Previews: PreviewProvider {
    static var previews: some View {
        DestinationStart()
    }
}

struct CreatAccount: View {
    var body: some View {
        HStack {
            Text("Don't have an account?")
                .font(.system(size: 13, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            NavigationLink(destination: CreatAccountView()) {
                Text("Create account")
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundColor(.red)
            }
        }
    }
}
