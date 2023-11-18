//
//  LoginView.swift
//  leFood
//
//  Created by Fridolin Karger on 18.11.23.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        Text("Login View")
        NavigationLink(value: Route.register) {
            PageButton(label: "Register")
        }
    }
}

#Preview {
    LoginView()
}
