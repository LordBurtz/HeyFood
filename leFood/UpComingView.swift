//
//  UpComingView.swift
//  leFood
//
//  Created by Fridolin Karger on 19.11.23.
//

import SwiftUI

struct UpcomingView: View {
//    let viewmodel: UpcomingViewModel
    
    @State var featured: Recipe? = nil
    @State var meals: [Recipe] = []
    @State var deleted: [Int] = []
    
    @Environment(\.scenePhase) var scenePhase

    @State var hasOrdered = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                let main = featured
                HeyGreetingCard(viewModel: .init(
                    description: main?.headline ?? "Problems getting your data",
                    imageURL: main?.imageURL,
                    imageDescription: main?.name,
                    showButton: false))
                
                AddMeal()
                HomeTitleSection(title: "Next weeks dinner")
                
                ForEach(meals, id: \.id) { recipe in
                    UpSingleView(deleted: $deleted, recipe: recipe)
                }
                
                Divider()
                
                PageButton(label: "Order") {
                    DataStore.shared.upcoming = meals.filter { deleted.contains([$0.id]) == false }
                    DataStore.shared.order()
                    hasOrdered.toggle()
                }
            }
            .padding(30)
        }
        .onChange(of: scenePhase, perform: { newPhase in
            switch newPhase {
            case .active:
                Task {
                    do {
                        try await loadFromDataStore()
                    }
                }
            case .inactive:
                saveToDataStore()
            default:
                print()
            }
        })
        .onAppear() {
            Task {
                do {
                    try await loadFromDataStore()
                }
            }
        }
        .onDisappear {
            if hasOrdered == false {
                
                saveToDataStore()
            }
        }
//        .setCustomNavBar()
    }
    
    func saveToDataStore() {
        DataStore.shared.upcoming = meals.filter { deleted.contains([$0.id]) == false }
    }
    
    func loadFromDataStore() async throws {
        self.featured = DataStore.shared.featured
        self.meals =  try await DataStore.shared.upcoming
    }
}

struct UpSingleView: View {
    @State var activeDel: Bool = false
    @State var shown: Bool = true
    var deleted: Binding<[Int]>
    
    let recipe: Recipe
    
    var body: some View {
        if shown {
            
            
            HStack {
                Image(systemName: "x.square")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.red)
                    .frame(width: 20)
                    .padding(5)
                    .onTapGesture {
                        deleted.wrappedValue.append(recipe.id)
                        shown = false
                    }
                
                MealPreview(recipe: recipe)
            }
            .animation(.smooth, value: activeDel)
            .gesture(
                DragGesture()
                    .onEnded { val in
                        if abs(val.translation.width) > 10 {
                            
                            activeDel.toggle()
                        }
                    }
            )
        }
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
    UpcomingView(featured: .init(id: 5))
}
