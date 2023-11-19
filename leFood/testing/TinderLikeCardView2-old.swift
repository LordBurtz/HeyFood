//
//  TinderLikeCardView2.swift
//  leFood
//
//  Created by Fridolin Karger on 18.11.23.
//

import SwiftUI

struct TinderLikeCardView2: View {
    var body: some View {
        VStack(alignment: .leading) {
            GeometryReader { geo in
                AsyncImage(url: URL(string: "https://www.24kitchen.nl/files/styles/social_media_share/public/2018-08/shutterstock_669057457.jpg?itok=RmTj3Q3a"))
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .shadow(radius: 5)
                
            }
            Divider()
            VStack(alignment: .leading) {
                Spacer()
                    .frame(maxHeight: 100)
                Text("Zubereitung 20 min")
                    .font(.custom("ZenAntique-Regular", size: 18))
                Text("Tags: High Protein Klimaheld")
                    .font(.custom("ZenAntique-Regular", size: 18))
                Text("650 Kalorien")
                    .font(.custom("ZenAntique-Regular", size: 18))
                Spacer()
                //                    .frame(maxHeight: 20)
                //                Text("Hey, do you want to save something fresh today? this saves up to 30% CO2 then others")
                //                    .font(.custom("ZenAntique-Regular", size: 20))
                //                    .foregroundStyle(Color.white)
                
                let html = """
                <style>
                    @font-face {
                      font-family: "ZenAntique-Regular";
                      src: url(https://github.com/googlefonts/zen-antique/blob/main/fonts/ttf/ZenAntique-Regular.ttf) format("truetype");
                    }
                </style>
                <p><span style="font-size: 28px; color: blue; font-family: "MS Comic Sans";">Hey ee,</span> do you want to save something fresh today? this saves up to 30% CO2 then others.</p>
"""
                
                HtmlLabel(html: html)
                }
            .frame(maxHeight: .infinity)
            
                
        }
        .padding(15)
        .overlay {
            TitleLabel()
        }
        .background {
            VStack {
                Spacer()
                LinearGradient(colors: [ColorAssets.green58.color.opacity(0.8), .clear], startPoint: .bottom, endPoint: .top)
                    .frame(maxHeight: 150)
                
            }
            .background {
                ColorAssets.greenCB.color
            }
        }
        .border(Color.gray, width: 3)
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .shadow(radius: 20)
        .padding(9)
    }
}

struct HtmlLabel: View {
    let html: String
    
    var body: some View {
        
        Text(createStr())
//        if let nsAttributedString = try? NSAttributedString(data: Data(html.utf8), options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil),
//           let attributedString = try? AttributedString(nsAttributedString, including: \.uiKit) {
//            Text(attributedString)
//        }
    }
    
    func createStr() -> AttributedString {
        let hey = "hey "
        let attributes: [NSAttributedString.Key: Any] = [
//            .foregroundColor: UIColor.white,
//            .backgroundColor: UIColor.red,
            .font: UIFont(name: "ZenAntique-Regular", size: 28) as Any
//            .font: .font(.custom("ZenAntique-Regular", size: 18))
        ]
        let attributedString = NSAttributedString(string: hey, attributes: attributes)
        
        let rest = "do you want to save something fresh today? this saves up to 30% CO2 then others."
        let restAttributes: [NSAttributedString.Key: Any] = [
            //            .foregroundColor: UIColor.white,
            //            .backgroundColor: UIColor.red,
            .font: UIFont(name: "ZenAntique-Regular", size: 18) as Any,
                        
            //            .font: .font(.custom("ZenAntique-Regular", size: 18))
                    ]
        let secondAttributedString = NSAttributedString(string: rest, attributes: restAttributes)

        let final = NSMutableAttributedString()
        final.append(attributedString)
        final.append(secondAttributedString)
        
        let strLength = final.length
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 0
        
        final.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: strLength))
        return AttributedString(final)
    }
}

struct TitleLabel: View {
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .center) {
                    Text("Smokey Hänchenfilet auf Avocado-Salat")
                        .font(.custom("ZenAntique-Regular", size: 28))
                        .frame(maxWidth: 255)
                        .multilineTextAlignment(.center)
            }
            .padding([.leading], 9)
            .background {
                Color.white
                    .opacity(0.8)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func buildTitle() -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: "Smokey Hänchenfilet auf Avocado-Salat")

        // Set font size and font
        let fontSize: CGFloat = 28
        let font = UIFont(name: "ZenAntique-Regular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
        var attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]
        

        // Set line spacing
        let lineSpacing: CGFloat = 10
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = .center
        attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle

        attributedString.addAttributes(attributes, range: NSRange(location: 0, length: attributedString.length))
        
        return attributedString
    }
}

#Preview {
    TinderLikeCardView2()
}
