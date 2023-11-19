//
//  NetworkManager.swift
//  leFood
//
//  Created by Fridolin Karger on 19.11.23.
//

import Foundation

enum RequestPath: String {
    case register = "/api/v1/auth/register"
    
    static var baseURL: String = "http://localhost:8000"
    
    var url: URL {
        URL(string: (Self.baseURL + self.rawValue))!
    }
}

struct RegisterModelRequest: Codable {
    let username: String
    let password: String
}

struct AuthenticationResponse: Codable {
    let accessToken: String
    let refreshToken: String
}

struct IngredientResponse: Codable {
    let name: String
    let link: String
}

class NetworkManager {
    static let shared = NetworkManager(accessToken: "", refreshToken: "")
    
    let accessToken: String
    let refreshToken: String
    
    var cachedRecipes: [Recipe]? = nil
    
    init(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
    
    func fetchRecipes() async throws -> [Recipe] {
        if let cached = cachedRecipes {
            return cached
        }
        let url = URL(string: "http://127.0.0.1:5000/homeview")!

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let recipes = try JSONDecoder().decode([Recipe].self, from: data).sorted { $0.id < $1.id }
            cachedRecipes = recipes
            return recipes
        } catch {
            throw error
        }
    }
}

