//
//  AwardsModel.swift
//  IDEat
//
//  Created by Hilary Young on 22/04/2023.
//

import SwiftUI

struct Award: Codable, Identifiable {
    var id: String?
    var awardImg: String
    var awardDetailImg: String
    var photoImg: String
    var windowText: String
    var title: String
    var subtitle: String
    var body: String
}

class apiAwardsCall {
    func getAwards(completion:@escaping ([Award]) -> ()) {
        guard let url = Bundle.main.url(forResource: "awards", withExtension: "json") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let awards = try! JSONDecoder().decode([Award].self, from: data!)
            //print(awards)
            
            DispatchQueue.main.async {
                completion(awards)
            }
        }
        .resume()
    }
}
