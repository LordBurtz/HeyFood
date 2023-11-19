//
//  RecipeView.swift
//  leFood
//
//  Created by Fridolin Karger on 18.11.23.
//

import SwiftUI

struct Ingredient {
    let name: String
    let type: String
    let imageLink: String
}

extension Ingredient {
    static let `default`: Ingredient = .init(
        name: "Orange",
        type: "Vegetable",
        imageLink: "http://example.com")
}

struct Nutrition: Decodable {
    let energy: Int
    let calories: Int
    let carbohydrate: Double
    let protein: Double
    
    static let `default`: Nutrition = .init(
        energy: 2534,
        calories: 606,
        carbohydrate: 52.4,
        protein: 38.4)
}

struct Recipe: Decodable {
    let id: Int
    let name: String
    let headline: String
    let prepTime: Int // in minutes
    let imageURL: String
    let websiteURL: String
    let tags: [String]
    let nutrition: Nutrition
}

extension Recipe {
    init(id: Int) {
        self.id = id
    name = "Harissa chicken on quinoa with green olives"
    headline = "this dish produces 50% less CO2e from ingredients than an average HelloFresh recipe"
    prepTime = 25
    imageURL = "https://pinchofyum.com/wp-content/uploads/Chipotle-Tahini-Bowls-with-Egg-Square.jpg"
    websiteURL = "https://www.hellofresh.de/recipes/balsamico-linsen-salat-mit-hahnchenbrust-64df2a75552e10127649f25f"
    tags = ["High Protein", "Under 650 Calories"]
    nutrition = .default
    }
    
    static let `default`: Recipe = .init(
        id: 1,
        name: "Harissa chicken on quinoa with green olives",
        headline: "this dish produces 50% less CO2e from ingredients than an average HelloFresh recipe",
        prepTime: 25,
        imageURL: "https://pinchofyum.com/wp-content/uploads/Chipotle-Tahini-Bowls-with-Egg-Square.jpg",
        websiteURL: "https://www.hellofresh.de/recipes/balsamico-linsen-salat-mit-hahnchenbrust-64df2a75552e10127649f25f",
        tags: ["High Protein", "Under 650 Calories"],
        nutrition: .default)
}

//struct RecipeCardView: View {
//    let recipe: Recipe
//    
//    var body: some View {
//        VStack {
//            Text(recipe.name)
//                .lineLimit(1)
//                .truncationMode(.tail)
//            
//            Divider()
//            
//            HStack {
//                ImageView(url: recipe.imageURL)
//                Text(recipe.headline)
//                    .lineLimit(2)
//            }
//        }
//        .padding(5)
//        .background {
//            RoundedRectangle(cornerRadius: 5)
//                .stroke(lineWidth: 1)
//        }
//    }
//}
//
//#Preview {
//    RecipeCardView(recipe: .default)
//        .padding(30)
//}
