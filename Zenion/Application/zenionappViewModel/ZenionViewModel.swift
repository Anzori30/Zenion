//
//  ZenionViewModel.swift
//  Zenion
//
//  Created by macbook on 19.04.23.
//

import SwiftUI

class ZenionViewModel: ObservableObject {
    @Published var one = 0
    @Published var destinationStart = Bool()
    
    init() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("LogOut"), object: nil, queue: .main) { notification in
            withAnimation {
                self.destinationStart = false
            }
            if self.one == 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        self.destinationStart = true
                        self.one = 1
                    }
                }
            } else {
                withAnimation {
                    self.destinationStart = true
                    self.one = 0
                }
            }
        }
        
        
    }

}


