//
//  ResponsiveFontSizes.swift
//  MakanLagi
//
//  Created by Hilary Young on 17/05/2023.
//

import SwiftUI


func LargeTitleSize() -> Int {
    let screenWidth = UIScreen.main.bounds.width
    
    // IPhone SE
    if screenWidth <= 380 {
        return 32
    } else {
        return 36
    }
}

func TitleSize() -> Int {
    let screenWidth = UIScreen.main.bounds.width
    
    // IPhone SE
    if screenWidth <= 380 {
        return 28
    } else {
        return 28
    }
}

func Title3Size() -> Int {
    let screenWidth = UIScreen.main.bounds.width
    
    // IPhone SE
    if screenWidth <= 380 {
        return 18
    } else {
        return 18
    }
}


func SESpacer() -> Int {
    let screenWidth = UIScreen.main.bounds.width
    
    // IPhone SE
    if screenWidth <= 380 {
        return 64
    } else {
        return 64
    }
}
