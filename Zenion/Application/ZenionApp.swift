//
//  ZenionApp.swift
//  Zenion
//
//  Created by macbook on 04.04.23.
//

import SwiftUI
import Firebase
import GoogleSignIn
@main
struct MyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let isUserLogginedIn = UserDefaults.standard.bool(forKey: "isLogined")
    var body: some Scene {
        WindowGroup {
            if isUserLogginedIn{
                 MyView(openView: AnyView(TabBarView()))
            }
            else{
                MyView(openView: AnyView(DestinationStart()))
            }
        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
     return true
    }
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
    
}


struct MyView: View {
    @State private var one = 0
    @State private var destinationStart = false
    @State private var destination = false
     var openView:AnyView
    var body: some View {
        if destination{
            DestinationStart()
        }
        else{
            if destinationStart {
                   openView
                    .onDisappear {
                        NotificationCenter.default.addObserver(forName: NSNotification.Name("LogOut"), object: nil, queue: .main) { notification in
                            withAnimation {
                                self.destinationStart = false
                                self.destination = true
                            }
                        }
                    }
                    .onAppear() {
                        NotificationCenter.default.addObserver(forName: NSNotification.Name("LogOut"), object: nil, queue: .main) { notification in
                            withAnimation {
                        self.destinationStart = false
                        self.destination = true
                  }
                }
              }
            } else {
                LaunchScreen()
                    .onAppear {
                        if one == 0 {
                            destination = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    destinationStart = true
                                    self.one = 1
                                }
                            }
                        } else {
                            withAnimation {
                                destinationStart = true
                                self.one = 0
                        }
                    }
               }
            }
        }
    }
}

