//
//  ProfilePageView.swift
//  Zenion
//
//  Created by macbook on 01.05.23.
//

import SwiftUI
import Kingfisher
struct ProfilePageView: View {
    var imageLink:String
    var name:String
    var email:String
  @State private var itemSelected = false
    @State private var showingAlert = false
    @State private var alerttext = "Error"
    var body: some View {
        ZStack{
            Color("light-brown")
                .ignoresSafeArea()
            VStack{
                HStack{
                    Text("Profile")
                        .font(.system(size: 25, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding([.leading,.trailing],20)
                Spacer()
            }
      
            VStack{
                Divider()
                List{
                    ProfilePageListItem(height: 100, mainText: "Edit profile photo", secundText: "", imageLink: imageLink, isturnDown: false, destination:AnyView(EmptyView()), downText: "") { }
                }
                .foregroundColor(.blue)
                .background(.clear)
                .scrollContentBackground(.hidden)
                .scrollDisabled(true)
                .frame(height: 170)
                ScrollView{
                    List{
                        ProfilePageListItem(height: 38, mainText: "Name", secundText: name, imageLink: "", isturnDown: false, destination: AnyView(EmptyView()), downText: "") {
                            alerttext = "The name cannot be changed"
                            showingAlert = true
                        }
                        ProfilePageListItem(height: 38, mainText: "E-mail", secundText: email, imageLink: "", isturnDown: false, destination: AnyView(EmptyView()), downText: "") {
                            alerttext = "The email cannot be changed"
                            showingAlert = true
                        }
                        ProfilePageListItem(height: 38, mainText: "Password", secundText: "", imageLink: "", isturnDown: true, destination: AnyView(ResetPasswordView()), downText: "Reset Password") { }
                        ProfilePageListItem(height: 38, mainText: "Payment details", secundText: "", imageLink: "", isturnDown: false, destination: AnyView(EmptyView()), downText: "") { }
                    }
                    .foregroundColor(.blue)
                    .background(.clear)
                    .scrollContentBackground(.hidden)
                    .scrollDisabled(true)
                    .frame(height: 350)
                    Button {
                        //action
                    } label: {
                        Text("Dellete account")
                            .foregroundColor(.red)
                    }
                }
            }
            .padding([.bottom])
            .alert(alerttext, isPresented: $showingAlert) {
                        Button("Ok", role: .cancel) { }
                }
        }
    }
}

struct ProfilePageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePageView(imageLink: "test", name: "dfsf", email: "sdas")
    }
}
fileprivate struct ProfilePageListItem: View {
  @State var height:Int
    var mainText:String
    var secundText:String
    var imageLink:String
    var isturnDown:Bool
    var destination:AnyView
    var downText:String
    let action: () -> Void
    @State private var buttonArrow = "chevron.right"
    @State private var seeMore = false
    var body: some View {
               Button {
                   if isturnDown{
                       withAnimation(.easeInOut(duration: 0.2)){
                           seeMore.toggle()
                       }
                       if seeMore{
                           buttonArrow = "chevron.up"
                       }
                       else{
                           buttonArrow = "chevron.right"
                       }
                   }
                    action()
                        } label: {
                            VStack{
                                HStack{
                                    Text(mainText)
                                        .foregroundColor(.white)
                                        .font(.system(size: 18, weight: .bold, design: .rounded))
                                    
                                    Spacer()
                                    Text(secundText)
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .bold, design: .rounded))
                                    if imageLink != ""{
                                        KFImage(URL(string: imageLink))
                                          .resizable()
                                            .frame(width: 60,height: 60)
                                            .cornerRadius(100)
                                    }
                                    Image(systemName: buttonArrow)
                                        .frame(width: 20,height: 60)
                                        .foregroundColor(.indigo)
                                }
                            }
                            
                        }
                        .listRowSeparatorTint(Color("light-brown"))
                    .listRowBackground(Color("Gray"))
                   .frame(height: CGFloat(height))
        
            if seeMore{
            NavigationLink(destination: destination){
                VStack{
                    Text(downText)
                    .font(.system(size: 18, weight: .bold, design: .rounded))}
                   .foregroundColor(.white)
            }
            .listRowBackground(Color("Gray"))
            .frame(height: 40)
        }
        
    }
}
