//
//  RootView.swift
//  leFood
//
//  Created by Fridolin Karger on 18.11.23.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        NavigationStack {
            FirstPage()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .login:
                        LoginView()
                    case .register:
                        RegisterView()
                    case .debugToHome:
                        HomeView()
                    }
                }
        }
    }
}

enum Route: Hashable {
    case login
    case register
    case debugToHome
}

#Preview {
    RootView()
}
