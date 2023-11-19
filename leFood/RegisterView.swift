//
//  RegisterView.swift
//  leFood
//
//  Created by Fridolin Karger on 18.11.23.
//

import SwiftUI

struct RegisterView: View {
    var body: some View {
        VStack {
            Text("Register View")
            NavigationLink(value: Route.login) {
                PageButton(label: "Login")
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RegisterView()
}
