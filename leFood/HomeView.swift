//
//  HomeView.swift
//  leFood
//
//  Created by Fridolin Karger on 18.11.23.
//

import SwiftUI

struct HomeView: View {
    let viewmodel: HomeViewModel
    
    @Environment(\.scenePhase) var scenePhase
    @State var meals: [Recipe] = []
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                let main = viewmodel.featured
                HeyGreetingCard(viewModel: .init(
                    description: main?.headline ?? "Check upcoming and select some recipes",
                    imageURL: main?.imageURL,
                    imageDescription: main?.name,
                    showButton: false))
                
                if viewmodel.configuredForHome {
                    SelectUpcomingView(accentColor: ColorAssets.green06.color)
                    HomeTitleSection(title: "This weeks dinner")
                } else {
                    AddMeal()
                    HomeTitleSection(title: "Next weeks dinner")
                }
                
                ForEach(meals, id: \.id) { recipe in
                    MealPreview(recipe: recipe)
                }
            }
            .padding(30)
        }
        .onAppear {
            loadFromDataStore()
        }
        .onChange(of: scenePhase, perform: { newPhase in
            switch newPhase {
            case .active:
                Task {
                    do {
                        try await loadFromDataStore()
                    }
                }
            default:
                print()
            }
        })
    }
    
    func loadFromDataStore() {
        meals = DataStore.shared.thisWeek
    }
}

struct HomeViewModel {
    let featured: Recipe?
    let meals: [Recipe]
    let configuredForHome: Bool
    
    func setConfig(for val: Bool) -> Self {
        .init(
            featured: self.featured,
            meals: self.meals,
            configuredForHome: val)
    }
    
    static let `default`: HomeViewModel = .init(
        featured: .default,
        meals: [.init(id: 1), .init(id: 2), .init(id: 3), .init(id: 4)],
        configuredForHome: true)
}

struct HomeTitleSection: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.custom("ZenAntique-Regular", size: 25))
            Spacer()
        }
        .overlay (
            Divider().background(Color.black), alignment: .bottom
        )
    }
}

struct SelectUpcomingView: View {
    let accentColor: Color
    
    var body: some View {
        NavigationLink(value: Route.upcoming) {
            HStack(alignment: .center) {
                Text("Select upcoming")
                    .font(.title2)
                    .foregroundStyle(Color.white)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30)
                    .foregroundStyle(.white)
                
            }
            .frame(maxWidth: .infinity)
            .padding(20)
            .background {
                RoundedRectangle(cornerRadius: 5)
                    .fill(accentColor)
                
            }
        }
        
    }
}

struct HeyGreetingCardViewModel {
    let description: String
    let imageURL: String?
    let imageDescription: String?
    let showButton: Bool
    
    static let `default`: HeyGreetingCardViewModel = .init(
        description: "looks like you have a lot to do tomorrow, how about a quick dinner?",
        imageURL: "https://pinchofyum.com/wp-content/uploads/Chipotle-Tahini-Bowls-with-Egg-Square.jpg",
        imageDescription: "Smokey Hänchenfilet auf Avocado-Salat",
        showButton: true)
}

struct HeyGreetingCard: View {
    let viewModel: HeyGreetingCardViewModel
    
    let primary = ColorAssets.green06.color
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Hey,")
                    .font(.custom("ZenAntique-Regular", size: 44))
                    .foregroundStyle(primary)
                Spacer()
            }
            HStack {
                
                Text(viewModel.description)
                    .foregroundStyle(primary)
                    .font(.custom("ZenAntique-Regular", size: 18))
                    .padding([.leading, .trailing], 7)
            }
            Spacer()
                .frame(height: 25)
            if
                let imgURL = viewModel.imageURL,
                let descr = viewModel.imageDescription {
                HStack {
                    Spacer()
                        .frame(maxWidth: 50)
                    AsyncImage(url: URL(string: imgURL)) { phase in
                        switch phase {
                        case .success(let img):
                            img
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        default:
                            Text("")
                        }
                    }
                    .overlay {
                        VStack {
                            Spacer()
                            HStack {
                                Text(descr)
                                    .multilineTextAlignment(.center)
                                    .font(.custom("ZenAntique-Regular", size: 22))
                            }
                            .frame(maxWidth: .infinity)
                            .background {
                                Color.white.opacity(0.8)
                            }
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .frame(width: 274, height: 274)
                    .shadow(radius: 5)
                }
                
                Spacer()
                    .frame(height: 25)
            }
            
            
            if viewModel.showButton {
                HStack {
                    Spacer()
                    Button(action: {} ) {
                        Text("Time to cook")
                            .foregroundStyle(ColorAssets.green2A.color)
                            .font(.custom("ZenAntique-Regular", size: 20))
                            .frame(width: 116, height: 33)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(ColorAssets.green92.color)
                            }
                            .shadow(radius: 5)
                    }
                }
            }
            
        }
        .padding([.trailing, .leading], 20)
        .padding([.top, .bottom], 5)
        .background {
            GeometryReader { geo in
                ZStack {
//                    ColorAssets.greenCB.color
                    Color.clear
                        .frame(maxHeight: geo.size.height / 2 + 10)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .offset(y: geo.size.height / 2 - 10)
                        .padding([.leading, .trailing], 10)
                    
//                    ColorAssets.green92.color
                    Color.white
                        .frame(maxHeight: geo.size.height / 2)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .border(primary)
//                        .shadow(radius: 10)
                    
                }
            }
        }
    }
}

struct MealPreview: View {
    let recipe: Recipe
    let primary = ColorAssets.green06.color
    
    var body: some View {
        NavigationLink(value: Route.webview(link: URL(string: recipe.websiteURL)!)) {
            HStack {
                Spacer().frame(width: 100)
                
                
                VStack {
                    HStack {
                        Text(recipe.name)
                            .font(.custom("ZenAntique-Regular", size: 18))
                            .foregroundStyle(Color.black)
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    HStack {
                        Text(recipe.nutrition.calories.description + "cal")
                            .foregroundStyle(ColorAssets.grayA3.color)
                            .font(.custom("ZenAntique-Regular", size: 18))
                        
                        Spacer()
                        Text(recipe.prepTime.description + "min")
                            .foregroundStyle(ColorAssets.grayA3.color)
                            .font(.custom("ZenAntique-Regular", size: 18))
                    }
                    .padding([.trailing], 20)
                }
            }
            .padding(5)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(primary, style: StrokeStyle())
            }
            .overlay {
                HStack {
                    AsyncImage(url: URL(string: recipe.imageURL)) { phase in
                        switch phase {
                        case .success(let img):
                            img
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            
                        default:
                            Text("")
                        }
                    }
                    .frame(width: 100)
                    .clipShape(Circle())
                    .offset(y: -15)
                    
                    Spacer()
                }
            }
            .padding([.top], 20)
        }
    }
}

struct AddMeal: View {
    var body: some View {
        NavigationLink(value: Route.tinderLike) {
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "plus.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(5)
                        .foregroundStyle(.white)
                        .padding(5)
                    
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 71)
            .background {
                RoundedRectangle(cornerRadius: 5)
                    .fill(ColorAssets.green06.color)
//                    .stroke(ColorAssets.grayC4.color, lineWidth: 2)
            }
        }
    }
}

#Preview {
    HomeView(viewmodel: .default)
}
