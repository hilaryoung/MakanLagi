//
//  Ingredients.swift
//  MakanLagi
//
//  Created by Hilary Young on 18/04/2023.
//

import Foundation

struct Ingredient: Codable, Identifiable, Hashable {
    let id: String?
    let enName: String
    let idName: String
    let ingIMG: String
}

class apiIngredientsCall {
    func getIngredients(completion:@escaping ([Ingredient]) -> ()) {
        guard let url = Bundle.main.url(forResource: "ingredients", withExtension: "json") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let ingredients = try! JSONDecoder().decode([Ingredient].self, from: data!)
            //print(ingredients)
            
            DispatchQueue.main.async {
                completion(ingredients)
            }
        }
        .resume()
    }
}
