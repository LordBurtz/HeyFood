//
//  FirstPage.swift
//  leFood
//
//  Created by Fridolin Karger on 18.11.23.
//

import SwiftUI

struct FirstPage: View {
    @State private var isValid = false
    @State var email: String = ""
    @State var pwd: String = ""
    
    var body: some View {
        VStack(spacing: 60) {
            VStack {
                Text("Welcome back!")
                    .font(.custom("ZenAntique-Regular", size: 35))
                    .foregroundStyle(ColorAssets.green06.color)
                Text("Login to start your culinary\n journey")
                    .multilineTextAlignment(.center)
                    .font(.custom("ZenAntique-Regular", size: 16))
                    .foregroundStyle(ColorAssets.grayA3.color)
            }
            
            VStack(spacing: 0) {
                VStack(alignment: .leading) {
                    Text("Email address")
                        .font(.custom("ZenAntique-Regular", size: 15))
                        .foregroundStyle(.black)
                        .offset(y: 12)
                    
                    TextField("", text: $email)
                        .padding()
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity, minHeight: 30)
                        .fixedSize(horizontal: false, vertical: true)
                        .background {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(ColorAssets.grayCB.color)
                                .strokeBorder(ColorAssets.green5F.color, style: StrokeStyle(lineWidth: 2))
                        }
                }
                .padding(0)
                
                VStack(alignment: .leading) {
                    Text("Password")
                        .font(.custom("ZenAntique-Regular", size: 15))
                        .foregroundStyle(.black)
                        .offset(y: 12)
                    
                    SecureField("", text: $pwd)
                        .padding()
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity, minHeight: 30)
                        .fixedSize(horizontal: false, vertical: true)
                        .background {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(ColorAssets.grayCB.color)
                                .strokeBorder(ColorAssets.green5F.color, style: StrokeStyle(lineWidth: 2))
                            
                        }
                        .onSubmit { validate() }
                }
                .padding(0)
            }
            VStack(spacing: 10) {
                NavigationLink(value: Route.home) {
                    PageButton(label: "Login")
                }
                
                NavigationLink(value: Route.signup) {
                    PageButton(label: "Register")
                }
            }
        }
        .padding([.leading, .trailing], 60)
    }
    
    func validate() {
        if email.isEmpty == false, pwd.isEmpty == false {
            
        }
    }
}

struct PageButton: View {
    let label: String
    var action: (() -> Void)?
    
    var body: some View {
        if let action {
            Button(role: .none, action: action) {
                Text(label)
                    .font(.custom("ZenAntique-Regular", size: 20))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(15)
                    .background {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(ColorAssets.green06.color)
                    }
                
            }
        } else {
            Text(label)
                    .font(.custom("ZenAntique-Regular", size: 20))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(15)
                    .background {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(ColorAssets.green06.color)
                    }
        }
    }
}

#Preview {
    FirstPage()
}

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
        
        NavigationLink(value: Route.debugToTinder) {
            PageButton(label: "Debug to Tinder")
        }
    }
    .fixedSize(horizontal: true, vertical: false)
}
