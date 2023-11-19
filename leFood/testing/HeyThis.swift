//
//  HeyThis.swift
//  leFood
//
//  Created by Fridolin Karger on 18.11.23.
//

import SwiftUI

struct HeyThis: View {
    var body: some View {
        VStack(spacing: 0) {
            HeyLabel()
            
            HStack {
                Button("Try this") { }
                    .foregroundStyle(Color.black)
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .background {
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .fill(Color.gray)
                    }
                ImageView(url: "https://www.pixelstalk.net/wp-content/uploads/2016/08/Fresh-hot-delicious-food-wallpaper.jpg")
            }
        }
    }
}

struct HeyLabel: View {
    let text = "are you still intereseted in eating healty and protein-rich"
    var body: some View {
        HStack {
            Text("Hey")
                .font(.system(size: 35))
            Text(text)
        }
    }
}

#Preview {
    HeyThis()
        .padding(30)
}
