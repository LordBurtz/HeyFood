//
//  HeyCard.swift
//  leFood
//
//  Created by Fridolin Karger on 18.11.23.
//

import SwiftUI

struct HeyTitleCard<T: View>: View {
    let description = "Very tasty food with a lot of calories, I like it quite a lot"
    let primary = ColorAssets.green06.color
    @State var shadowDisabled = true
    @ViewBuilder let content: () -> T
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Hey,")
                    .font(.custom("ZenAntique-Regular", size: 44))
                    .foregroundStyle(primary)
                Spacer()
            }
            HStack {
                
                Text("looks like you have a lot to do tomorrow, how about a quick dinner?")
                    .foregroundStyle(primary)
                    .font(.custom("ZenAntique-Regular", size: 18))
                    .padding([.leading, .trailing], 7)
            }
            Spacer()
                .frame(height: 20)
            
            content()
        }
        .padding([.trailing, .leading, .bottom], 20)
        .padding([.top], 5)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .foregroundColor(primary)
                .backgroundStyle(.white)
                .shadow(radius: 10)
        )
        .background(
            Rectangle()
                .fill(Color.white)
                .cornerRadius(12)
                .shadow(
                    color: Color.gray.opacity(shadowDisabled ? 1 : 0.7),
                    radius: 8,
                    x: 0,
                    y: 0
                )
                    
        )
    
    }
}

#Preview {
    HStack {
        HeyTitleCard() {
            Circle()
                .frame(height: 100)
        }
    }
    .padding(20)
}
