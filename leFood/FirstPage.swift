//
//  FirstPage.swift
//  leFood
//
//  Created by Fridolin Karger on 18.11.23.
//

import SwiftUI

struct FirstPage: View {
    
    
    var body: some View {
        VStack(alignment: .center) {
            NavigationLink(value: Route.login) {
                PageButton(label: "Login")
            }
            
            NavigationLink(value: Route.register) {
                PageButton(label: "Register")
            }
            
            NavigationLink(value: Route.debugToHome) {
                PageButton(label: "Debug To Home")
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("List").foregroundColor(.white)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.orange, for: .navigationBar)
        .fixedSize(horizontal: true, vertical: false)
    }
}



struct PageButton: View {
    let label: String
    let action: () -> Void = {}
    
    var body: some View {
        Text(label)
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity)
            .padding(10)
            .background {
                RoundedRectangle(cornerRadius: 5)
                    .strokeBorder(Color.green, lineWidth: 1)
            }
    }
}

#Preview {
    FirstPage()
}
