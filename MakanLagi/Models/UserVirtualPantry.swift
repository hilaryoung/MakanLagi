//
//  UserVirtualPantry.swift
//  MakanLagi
//
//  Created by Hilary Young on 16/04/2023.
//

import Foundation

struct UserVirtualPantry: Identifiable {
    var id: String?
    var itemName: String
    var expDate = Date()
}

struct User: Identifiable {
    let id: String
    let firstName: String
}

