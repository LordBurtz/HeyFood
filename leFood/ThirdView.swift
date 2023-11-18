//
//  ThirdView.swift
//  leFood
//
//  Created by Fridolin Karger on 18.11.23.
//

import SwiftUI

struct ThirdView: View {
    var body: some View {
        Text("Third View")
        NavigationLink(value: Route.login) {
            PageButton(label: "Login")
        }
    }
}

#Preview {
    ThirdView()
}
