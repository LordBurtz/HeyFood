//
//  TestZack.swift
//  leFood
//
//  Created by Fridolin Karger on 18.11.23.
//

import SwiftUI

struct TestZack: View {
    @State var list = [1,2,3,4,5,6,7,8]
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            ZStack {
                ForEach(list, id: \.self) { num in
                    Text(num.description)
                        .padding()
                        .border(Color.black)
                        .background {
                            Color.white
                        }
                        .gesture(
                            DragGesture()
                                .onEnded { value in
                                    
                                }
                        )
                }
            }
        }
    }
}

#Preview {
    TestZack()
}
