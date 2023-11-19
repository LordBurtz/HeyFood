//
//  ChatView.swift
//  leFood
//
//  Created by Fridolin Karger on 19.11.23.
//

import SwiftUI

struct ChatView: View {
    let messages: [Message]
    @State var textfield: String = ""
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(messages, id: \.content.hash) { msg in
                    HStack {
                        if msg.fromUser {
                            Spacer()
                            SpeechBubble(title: nil, bodyText: msg.content, fromLeft: true)
                            
                        } else {
                            SpeechBubble(title: nil, bodyText: msg.content, fromLeft: false, backgroundColor: ColorAssets.greenCB.color)
                            
                            Spacer()
                        }
                    }
                }
            }
            VStack {
                HStack {
                    TextField("Ask a question", text: $textfield, axis: .vertical)
                        .lineLimit(2...7)
                    
                    Image(systemName: "paperplane.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                        .foregroundStyle(ColorAssets.green06.color)
                        .padding([.trailing], 10)
                }
                
            }
        }
        .padding()
    }
}

struct Message {
    let content: String
    let fromUser: Bool
    
    static let defaultUser: Message = .init(
        content: "Default message, beautiful name >)",
        fromUser: true)
    
    static let defaultBot: Message = .init(
        content: "You look kinda tired, maybe some Tikka Massala will help you",
        fromUser: false)
    
    static let someMessages: [Message] = [.defaultUser, .defaultBot, .defaultBot, .defaultUser, .defaultUser, .defaultBot, .defaultUser, .defaultBot, .defaultUser, .defaultBot, .defaultUser]
}

#Preview {
    ChatView(messages: Message.someMessages)
}
