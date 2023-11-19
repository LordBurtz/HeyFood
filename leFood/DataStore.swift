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
    
    var selected: [Recipe] = []
    var cachedRecipes: [Recipe]? = nil
    
    func fetchRecipes() async throws -> [Recipe] {
        return []
//        let result = try await NetworkManager.shared.fetchRecipes()
//        cachedRecipes = result
//        return result
    }
}
