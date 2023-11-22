//
//  DataStore.swift
//  leFood
//
//  Created by Fridolin Karger on 19.11.23.
//

import Foundation

struct User: Codable {
    let userID: String
    let token: String
}

struct DataStoreConfig {
    var baseUrl: String = "http://localhost:8000"
}

class DataStore {
    static let shared = DataStore()
    
    // featured on the pages
    var featured: Recipe? = nil
    
    var selected: [Recipe] = []
    var thisWeek: [Recipe] = [] // displayed on home
    var upcoming: [Recipe] = [] // the ones selected on Upcoming
    var cachedRecipes: [Recipe]? = nil // all the data
    
    func order() {
        thisWeek = upcoming
        upcoming = []
    }
    
    @discardableResult
    func fetchRecipes() async throws -> [Recipe] {
        if cachedRecipes == nil {
//            cachedRecipes = [.init(id: 1), .init(id: 2), .init(id: 3), .init(id: 4), .init(id: 0)]
            let result = try await NetworkManager.shared.fetchRecipes()
            cachedRecipes = result
        }
        if featured == nil {
            featured = cachedRecipes?.first
        }
        return cachedRecipes!
//        let result = try await NetworkManager.shared.fetchRecipes()
//        cachedRecipes = result
//        return result
    }
}
