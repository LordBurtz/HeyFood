//
//  RootView.swift
//  leFood
//
//  Created by Fridolin Karger on 18.11.23.
//

import SwiftUI

struct RootView: View {
    let manager = NetworkManager(accessToken: "", refreshToken: "")
    var added = false
    
    var body: some View {
        NavigationStack {
            FirstPage()
                .navigationDestination(for: Route.self) { route in
                    
                    switch route {
                    case .login:
                        LoginView()
                    case .register:
                        RegisterView()
                    case .home, .debugToHome:
                        let recipes = DataStore.shared.selected
                        HomeView(viewmodel: .default)
                            .setCustomNavBar(title: "Hey")
                    case .tinderLike, .debugToTinder:

                        let newcolors = DataStore.shared.cachedRecipes ?? []
                        TinderLikeView()
//                            .setCustomNavBar(title: "Hey")

                            
                        
                    case .webview(let url):
                        WebView(url: url)
                    case .firstPage:
                        FirstPage()
                    case .upcoming:
                        HomeView(viewmodel: .default.setConfig(for: false))
                            .setCustomNavBar(title: "Hey")
                    case .chat:
                        ChatView(messages: Message.someMessages)
                            .setCustomNavBar(title: "Hey")

                    case .signup:
                        SignupView()
                    }
                }
        }
    }
}

enum Route: Hashable {
    case login
    case register
    case webview(link: URL)
    case firstPage
    case upcoming
    case tinderLike
    case home
    case chat
    case signup
    
    // MARK: navigation behaviour
//    case back
    
    // MARK: debug section
    case debugToHome
    case debugToTinder
}

extension View {
    func setCustomNavBar(title: String = "Home") -> some View {
        return self
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(title)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    HStack(spacing: 20) {
                        NavigationLink(value: Route.home) {
                            Image(systemName: "house")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 20)
                        }
                        Divider()
                        NavigationLink(value: Route.upcoming) {
                            Image(systemName: "fork.knife.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 20)
                        }
                        Divider()
                        NavigationLink(value: Route.tinderLike) {
                            Image(systemName: "forward.frame.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 20)
                        }
                        Divider()
                        NavigationLink(value: Route.chat) {
                            Image(systemName: "bubble.left.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 20)
                        }
                        
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(ColorAssets.green5F.color, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(ColorAssets.green5F.color, for: .bottomBar)
            .toolbarBackground(.hidden, for: .bottomBar)
    }
    
    func setEnterNavBar() -> some View {
        return self
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("HeyFood")
        .toolbarBackground(ColorAssets.green5F.color, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        
    }
}

#Preview {
    RootView()
}
