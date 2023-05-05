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
    @StateObject var viewModel = ProfilePageViewModel()
    @State private var inputImage : UIImage?
    @State private var showingPicker = false
    @State private var itemSelected = false
    @State private var showingAlert = false
    @State private var alerttext = "Error"
    @State var showDeleteAlert = false
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
                    ProfilePageListItem(height: 100, mainText: "Edit profile photo", secundText: "", imageLink: viewModel.imageUrl, isturnDown: false, destination:AnyView(EmptyView()), downText: "") {
                        showingPicker = true
                    }
                    .sheet(isPresented: $showingPicker, onDismiss: loadImage){
                        ImagePicker(image: $inputImage)
                    }
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
                        viewModel.deleteAccount()
                    } label: {
                        Text("Dellete account")
                            .foregroundColor(.red)
                    }
                }
                .alert(isPresented: $viewModel.showErrorAlert) {
                    Alert(title: Text("Error"), message: Text(viewModel.errorDescription), dismissButton: .default(Text("OK")))
                }
            }
            .padding([.bottom])
            .alert(alerttext, isPresented: $showingAlert) {
                        Button("Ok", role: .cancel) { }
            }
        }
        .onAppear{
            viewModel.takeLInk()
        }
        .overlay(
           HStack{
               if viewModel.indicator {
                   ActivityIndicator(isAnimating: true)
                       .foregroundColor(.red)
                       .frame(width: 80)
               }
        })
    }
    func loadImage(){
        guard let inputImage1 = inputImage else {
            print("inputImage is nil")
            return
        }
        print("inputImage is not nil: \(inputImage1)")
        viewModel.indicator = true
        PhotoUploader().uploadPhoto( image: inputImage1)
        PhotoUploader().imageLink()
    }

}
struct ProfilePageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePageView(imageLink: "test", name: "dfsf", email: "sdas")
    }
}

