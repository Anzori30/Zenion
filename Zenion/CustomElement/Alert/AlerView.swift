//
//  AlerView.swift
//  Zenion
//
//  Created by macbook on 09.05.23.
//

import SwiftUI

struct AletView: View {
    var headText:String
    var Message:String
    @State var showAlert : Bool
    var action: () -> Void
  
    var body: some View {
        VStack{ }
        .alert(headText, isPresented: $showAlert) {
            Button("Delete", role: .destructive) {}
            Button("OK") { action() }
        } message: {
            Text(Message)
        }
    }
}


