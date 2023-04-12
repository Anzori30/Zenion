//
//  PrivacypPolicyView.swift
//  Zenion
//
//  Created by macbook on 12.04.23.
//

import SwiftUI

struct PrivacypPolicyView: View {
    var body: some View {
            Text("privacy policy")
                .foregroundColor(.white)
                .font(.system(size: 12, weight: .bold,design: .rounded))
            Link("Team of Service", destination: URL(string: "https://www.apple.com")!)
                .foregroundColor(.purple)
                .font(.system(size: 12, weight: .bold,design: .rounded))
    }
}


