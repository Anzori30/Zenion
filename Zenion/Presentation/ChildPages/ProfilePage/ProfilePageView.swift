//
//  ProfilePageView.swift
//  Zenion
//
//  Created by macbook on 01.05.23.
//

import SwiftUI
import Kingfisher
import PhotosUI
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

struct ImagePicker: UIViewControllerRepresentable {
   
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
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
