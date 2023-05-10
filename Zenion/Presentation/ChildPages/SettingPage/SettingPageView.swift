//
//  SettingPageView.swift
//  Zenion
//
//  Created by macbook on 09.05.23.
//

import SwiftUI

struct SettingPageView: View {
    @State private var showViewing = true
    @State private var showAlert = false
    @StateObject var viewModel = SettingViewModel()
    var body: some View {
        ZStack{
            Color("light-brown")
            .ignoresSafeArea()
            VStack{
                HStack{
                    Text("Settings")
                        .font(.system(size: 25,weight: .bold,design: .rounded))
                        .foregroundColor(.white)
                        .padding([.leading,.trailing],30)
                    Spacer()
                }
                VStack{
                    List{
                        Toggle("Hide Continue viewing ", isOn: $showViewing)
                            .toggleStyle(SwitchToggleStyle(tint: .purple))
                            .listRowBackground(Color("Gray"))
                            .onTapGesture {
                            }
                    }
                    .foregroundColor(.blue)
                    .background(.clear)
                    .scrollContentBackground(.hidden)
                    .scrollDisabled(true)
                    .frame(height: 80)
                    Spacer()
                    List{
                        ProfilePageListItem(height: 30, mainText: "Clear history", secundText: "", imageLink: "", isturnDown: false, destination: AnyView(EmptyView()), downText: "", navigation: true, action: {
                           showAlert = true
                        })
                    }
                    .foregroundColor(.blue)
                    .background(.clear)
                    .scrollContentBackground(.hidden)
                    .scrollDisabled(true)
                    .alert("Are you sure?", isPresented: $showAlert) {
                              Button("NO", role: .cancel) {}
                        Button("YES") {viewModel.clearHistory()}
                    } message: {
                            Text("This will clear your history.")
                    }
                }
                Spacer()
            }
        }
        .onAppear{
            showViewing = viewModel.hideView
        }
        .onDisappear{
            viewModel.hidenViewing(Hide: showViewing)
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

struct SettingPageView_Previews: PreviewProvider {
    static var previews: some View {
        SettingPageView()
    }
}
