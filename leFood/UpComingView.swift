//
//  UpComingView.swift
//  leFood
//
//  Created by Fridolin Karger on 19.11.23.
//

import SwiftUI

struct UpcomingView: View {
    let viewmodel: UpcomingViewModel
    let activeDel: Bool = true
    
    @State var meals: [Recipe] = []
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                let main = viewmodel.featured
                HeyGreetingCard(viewModel: .init(
                    description: main.headline,
                    imageURL: main.imageURL,
                    imageDescription: main.name,
                    showButton: false))
                
                AddMeal()
                HomeTitleSection(title: "Next weeks dinner")
                
                ForEach(meals, id: \.id) { recipe in
                    HStack {
                        Image(systemName: "x.square")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.red)
                            .frame(width: activeDel ? 20 : 0)
                            
                        MealPreview(recipe: recipe)
                    }
                }
            }
            .padding(30)
        }
        .onAppear() {
            Task {
                do {
                    self.meals = try await DataStore.shared.fetchRecipes()
                    self.meals.append(contentsOf: viewmodel.meals)
                }
            }
        }
        .setCustomNavBar()
    }
}

struct UpcomingViewModel {
    let featured: Recipe
    let meals: [Recipe]
    let configuredForHome: Bool
    
    func setConfig(for val: Bool) -> Self {
        .init(
            featured: self.featured,
            meals: self.meals,
            configuredForHome: val)
    }
    
    static let `default`: UpcomingViewModel = .init(
        featured: .default,
        meals: [.init(id: 1), .init(id: 2), .init(id: 3), .init(id: 4)],
        configuredForHome: true)
}

#Preview {
    UpcomingView(viewmodel: .default)
}
