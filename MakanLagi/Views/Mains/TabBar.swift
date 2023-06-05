//
//  TabBar.swift
//  MakanLagi
//
//  Created by Hilary Young on 02/05/2023.
//

import SwiftUI

struct TabBar: View {
    
    let placeholderImage =  "https://firebasestorage.googleapis.com/v0/b/makanlagi-f9b8c.appspot.com/o/juice.png?alt=media&token=252c3688-441e-4db4-963e-f0f6af323da2"
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            ReinventView()
                .tabItem {
                    Label("Reinvent", systemImage: "square.fill.text.grid.1x2")
                    
                }
            
            VirtualPantryView()
                .tabItem {
                    Label("Pantry", systemImage: "plus")
                }
            
            SettingView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
            
        }
        .accentColor(.black) // Alternatively, you can set accentColor on the TabView
        .background(Color.blue)
    }
}

//struct TabBar_Previews: PreviewProvider {
//    static var previews: some View {
//        TabBar()
//    }
//}
