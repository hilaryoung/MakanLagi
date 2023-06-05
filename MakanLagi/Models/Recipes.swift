//
//  Recipes.swift
//  MakanLagi
//
//  Created by Hilary Young on 19/04/2023.
//

import Foundation

struct Recipe: Codable, Identifiable, Hashable {
    let id: String?
    let name: String
    let origin: String
    let time: Int
    let level: String
    let serving: Int
    let ingredients: [IngredientList]
    let steps: [String]
    let celebration: String
    let funFact: String
    let history: String
    let author: String
    let credLink: String
    let thumbnailIMG: String
    let coverIMG: String
    let extraIMG: String
    let mapImg: String
    
    struct IngredientList: Codable, Hashable {
        let quantity: String
        let measurement: String
        let name: String
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.id == rhs.id
    }
    
    // time formatter
    var formattedTime: String {
        let hours = time / 60
            let minutes = time % 60
            if hours == 0 {
                return "\(minutes)m"
            } else {
                return "\(hours)h \(minutes)m"
            }
    }
    
}

class apiRecipesCall {
    func getRecipes(completion:@escaping ([Recipe]) -> ()) {
        guard let url = Bundle.main.url(forResource: "recipes", withExtension: "json") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let recipes = try! JSONDecoder().decode([Recipe].self, from: data!)
            DispatchQueue.main.async {
                completion(recipes)
            }
        }
        .resume()
    }
}
