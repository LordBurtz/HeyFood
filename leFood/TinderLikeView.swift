//
//  TinderLikeView.swift
//  leFood
//
//  Created by Fridolin Karger on 18.11.23.
//

import SwiftUI

struct TinderLikeView: View {
    @State var colors: [Recipe] = [] //  = [.init(id: 1), .init(id: 2), .init(id: 3), .init(id: 4), .init(id: 5), .init(id: 6), .init(id: 7), .init(id: 8)]
    @State var index = 0
    @State var XdragOffset: CGFloat = 0
    @State var YdragOffset: CGFloat = 0
    @State var foreOpacity: Double = 1
    @State var disabled: [Int] = []
    @State var chosen: [Int] = []
    
    var Ysign: Double {
        YdragOffset < -1 ? -1 : 1
    }
    
    var nextIndex: Int {
        (index + 1) % colors.count
    }
    
    var body: some View {
        VStack {
            if false {
                TinderHeaderView()
            }
            
            ZStack {
                ForEach(self.colors, id: \.id) { recipe in
                    if disabled.contains(recipe.id) == false {
                        HeyTitleCard(description: recipe.headline) {
                            Spacer()
                            AsyncImage(url: URL(string: recipe.imageURL)!) { phase in
                                switch phase {
                                case .success(let img):
                                    img
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                    
                                default:
                                    Text("")
                                }
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay {
                                VStack {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        Text(recipe.name)
                                            .font(.custom("ZenAntique-Regular", size: 20))
                                            .multilineTextAlignment(.center)
                                        Spacer()
                                    }
                                    .background(Color.white.opacity(0.8))
                                }
                            }
                            .padding(20)
                        }
                        .frame(maxWidth: .infinity  )
                        .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
                        .rotationEffect(Angle(degrees: (recipe.id == colors.count - (index)) ? XdragOffset * 0.1 : 0))
                        .offset(CGSize(
                            width: (recipe.id == colors.count - (index)) ? XdragOffset : 0,
                            height: (recipe.id == colors.count - (index)) ? YdragOffset : 0))
                        .opacity(foreOpacity)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    self.XdragOffset = value.translation.width
                                    self.YdragOffset = value.translation.height
                                    
                                    if value.translation.width.isNeg {
                                        foreOpacity = Double(1 + XdragOffset * 0.001)
                                    }
                                }
                                .onEnded { value in
                                    withAnimation(.none) {
                                        
                                        // to the left
                                        if value.translation.width < -50 {
                                            if (recipe.id == colors.count - (index)) {
                                                disabled.append(recipe.id)
                                            }
                                            rightSwipe()
                                        }
                                        
                                        // this one is direction right
                                        if value.translation.width > 50 {
                                            if (recipe.id == colors.count - (index)) {
                                                disabled.append(recipe.id)
                                            }
                                            leftSwipe()
                                        }
                                        
                                        XdragOffset = 0
                                        YdragOffset = 0
                                        foreOpacity = 1
                                    }
                                }
                        )
                        
                    }
                }
            
            }
            .padding(20)
            
            if disabled.count < colors.count {
                HStack {
                    Spacer()
                    Text("\(index + 1) / \(colors.count)")
                        .font(.custom("ZenAntique-Regular", size: 24))
                    Spacer()
                }
            } else {
                HeyTitleCard (description: "looks like you're all caught up and ready to start your week, thanks for choosing HeyFood") {

                    
                }
                .padding(20)
            }
        }
        .onAppear {
            Task {
                do {
                    colors = (DataStore.shared.cachedRecipes ?? []).sorted(by: { $0.id < $1.id })
                }
            }
        }
//        .onDisappear { saveToDataStore() }
        
        .setCustomNavBar()
    }
    
    func saveToDataStore() {
        DataStore.shared.upcoming.append(contentsOf:  colors.filter { a in
                chosen.contains { a.id  == $0 }
            })
        
        DataStore.shared.upcoming = Array(Set(DataStore.shared.upcoming))
    }
    
    func advance() {
        index = nextIndex
    }
    
    func leftSwipe() {
        chosen.append(index)
        saveToDataStore()
        print("i left")
        advance()
    }
    
    func rightSwipe() {
        print("i right")
        advance()
    }
}

struct TinderHeaderView: View {
    var body: some View {
        HStack() {
            Image(systemName: "chevron.left")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 20)
            Text("Go back")
            Spacer()
        }
        .padding([.leading], 15)
        .padding([.top, .bottom], 5)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
        }
        .padding([.leading, .trailing], 20)
    }
}

struct TinderRecipeCardView: View {
    var color: Color
    
    var body: some View {
        VStack {
            
            Text(color.description)
            
        }

        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            VStack {
                Spacer()
                VStack(alignment: .leading) {
                    Text("Pizza")
                        .font(.system(.title2))
                    Text("Hey, this food saves up to 30% co2 compared to others")
                }
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
                .background {
                    LinearGradient(gradient: Gradient(colors: [.black.opacity(0.5), .black]), startPoint: .top, endPoint: .bottom)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .foregroundStyle(Color.white)
                
                
            }
            
        }
        .background {
            color

        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension CGFloat {
    var isNeg: Bool {
        self < 0
    }
}

#Preview {
    TinderLikeView(colors: [.init(id: 1), .init(id: 2), .init(id: 3), .init(id: 4), .init(id: 5), .init(id: 6), .init(id: 7), .init(id: 8)])
}
