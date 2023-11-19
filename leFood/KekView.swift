//
//  KekView.swift
//  leFood
//
//  Created by Fridolin Karger on 19.11.23.
//

import SwiftUI

struct SpeechBubble: View {
    
    let title: String?
    var titleColor: Color?
    var titleFont: Font?
    let bodyText: String
    let bodyTextColor: Color
    var bodyTextFont: Font?
    var backgroundColor = Color.green
    let cornerRadius: CGFloat = 17
    var groupTitleAndText = false
    var fromLeft: Bool = false
    var borderColor: Color
    
    init(title: String?,
         titleColor: Color = .black,
         titleFont: Font? = .system(size: 14, weight: .bold),
         bodyText: String,
         bodyTextColor: Color = .black,
         bodyTextFont: Font = .system(size: 14, weight: .regular),
         groupTitleAndText: Bool = false,
         fromLeft: Bool = false,
         backgroundColor: Color = .green,
         borderColor: Color = .clear) {
        
        self.title = title
        self.titleColor = titleColor
        self.titleFont = titleFont
        self.bodyText = bodyText
        self.bodyTextColor = bodyTextColor
        self.bodyTextFont = bodyTextFont
        self.groupTitleAndText = groupTitleAndText
        self.fromLeft = fromLeft
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                
                if groupTitleAndText {
                    GroupingTitleAndText(
                        title: title,
                        titleColor: titleColor,
                        titleFont: titleFont,
                        bodyText: bodyText,
                        bodyTextColor: bodyTextColor,
                        bodyTextFont: bodyTextFont
                    )
                    
                } else {
                    TitleAndText(
                        title: title,
                        titleColor: titleColor,
                        titleFont: titleFont,
                        bodyText: bodyText,
                        bodyTextColor: bodyTextColor,
                        bodyTextFont: bodyTextFont
                    )
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding()
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
        }
        .padding(10)
        .background(
            VStack {
                Spacer()
                HStack(alignment: .bottom) {
                    SpeechHookShape(radius: cornerRadius)
                        .fill(backgroundColor)
                        .border(borderColor)
                        .frame(width: cornerRadius * 2, height: cornerRadius * 2, alignment: .center)
                        .offset(x: -7, y: -9)
                    Spacer()
                }
            }
                .rotation3DEffect(.degrees(fromLeft ? 180 : 0), axis: (x: 0, y: -10, z: 0))
        )
    }
    
}

struct TitleAndText: View {
    var title: String?
    var titleColor: Color?
    var titleFont: Font?
    var bodyText: String
    var bodyTextColor: Color
    var bodyTextFont: Font?
    
    var body: some View {
        if let title = title, !title.isEmpty {
            HStack {
                Text(title)
                    .font(titleFont)
                    .foregroundColor(titleColor)
                Spacer()
            }
        }
        HStack {
            Text(bodyText)
                .font(bodyTextFont)
                .foregroundColor(bodyTextColor)
            Spacer()
            
        }
    }
}

struct GroupingTitleAndText: View {
    var title: String?
    var titleColor: Color?
    var titleFont: Font?
    var bodyText: String
    var bodyTextColor: Color
    var bodyTextFont: Font?
    
    var body: some View {
        if let title = title, !title.isEmpty {
            HStack {
                (Text(title)
                    .font(titleFont)
                    .foregroundColor(titleColor)
                +
                Text(bodyText)
                    .font(bodyTextFont)
                    .foregroundColor(bodyTextColor))
                Spacer()
                
            }
        }
    }
}

struct SpeechHookShape: Shape {
    let radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let centerY = rect.midY
        let cornerRadius: CGFloat = radius * 2
        
        let centerPoint1 = CGPoint(x: 0, y: centerY)
        let centerPoint2 = CGPoint(x: 10, y: centerY + radius - cornerRadius)

        var path = Path()

        path.addArc(center: centerPoint1, radius: radius, startAngle: .degrees(-10), endAngle: .degrees(75), clockwise: false)
        path.addArc(center: centerPoint2, radius: cornerRadius, startAngle: .degrees(90), endAngle: .degrees(45), clockwise: true)

        return path
    }
}

struct SpeechBubble_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SpeechBubble(
                title: "Good morning Mr Max Mustermann,",
                bodyText: "Another great day in  lot to enjoy today. Another great day in  lot to enjoy today.")

            SpeechBubble(
                title: "groupTitleAndText,",
                bodyText: "Another great day in  lot to enjoy today. Another great day in  lot to enjoy today.",
                groupTitleAndText: true)

            SpeechBubble(
                title: "groupTitleAndText,",
                bodyText: "Another .",
                groupTitleAndText: true)

            SpeechBubble(
                title: "shor,",
                bodyText: "Another ",
                groupTitleAndText: false)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

struct SpeechHook_Previews: PreviewProvider {
    static var previews: some View {
        SpeechHookShape(radius: 50)
            .fill(Color.gray)
            .frame(width: 160, height: 100, alignment: .center)
            
            .previewLayout(.sizeThatFits)
    }
}
