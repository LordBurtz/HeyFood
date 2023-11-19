//
//  SignupView.swift
//  leFood
//
//  Created by Fridolin Karger on 19.11.23.
//

import SwiftUI

struct SignupView: View {
    @State var name: String = ""
    @State var email: String = ""
    @State var pwd: String = ""
    @State var pwdTwice: String = ""
    
    var body: some View {
        VStack {
            Text("Create An Account")
                .font(.custom("ZenAntique-Regular", size: 30))
                .foregroundStyle(ColorAssets.green06.color)
            
            VStack(spacing: 20) {
                InputView(label: "Name", binding: $name)
                InputView(label: "Email", binding: $email)
                InputView(label: "Password", binding: $pwd)
                InputView(label: "Confirm Password", binding: $pwdTwice)
            }
            
            Spacer()
                .frame(maxHeight: 40)
            
            NavigationLink(value: Route.home) {
                HStack {
                    PageButton(label: "Registrieren")
                }
            }
        }
        .padding([.leading, .trailing], 50)
    }
}

struct InputView: View {
    let label: String
    var binding: Binding<String>
    
    var body: some View {
        TextField(label, text: binding)
            .padding()
            .font(.system(size: 20))
            .frame(maxWidth: .infinity, minHeight: 20)
            .fixedSize(horizontal: false, vertical: true)
            .background {
                RoundedRectangle(cornerRadius: 5)
                    .fill(ColorAssets.grayCB.color)
                    .strokeBorder(ColorAssets.green5F.color, style: StrokeStyle(lineWidth: 2))
            }
    }
}

#Preview {
    SignupView()
}
