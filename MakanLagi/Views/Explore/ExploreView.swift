//
//  ExploreView.swift
//  MakanLagi
//
//  Created by Hilary Young on 04/05/2023.
//

import SwiftUI

struct ExploreView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) private var dismiss
    
    @State private var recipes: [Recipe] = [] // Store fetched recipes in a @State property
    @State private var selectedOrigin: String?
    @State private var visibleRecipes: [Recipe] = []
    @State private var visibleCount = 6
    
    var body: some View {
        ZStack{
            Color(hex: "FFF9F0").edgesIgnoringSafeArea(.all) // background color
            ScrollView {
                ZStack{
                    VStack(alignment: .leading){
                        
                        // MARK: Header
                        Group{
                            Spacer().frame(height: 12)
                            Text("Explore recipes")
                                .font(.custom("PlayfairDisplay-Bold", size: 28, relativeTo: .title))
                                .foregroundColor(Color(hex: "3A290E"))
                                .fontWeight(.bold)
                            Spacer().frame(height: 8)
                            Text("from all the provinces in Indonesia")
                                .font(.custom("Montserrat-Regular", size: 18, relativeTo: .title3))
                            Spacer().frame(height: 16)
                        }
                        
                        Spacer().frame(height: 32)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                
                                Spacer().frame(width: 0.0001) // ensures padding on first view
                                
                                // 1. MARK: SHOW ALL
                                Button(action: {
                                    selectedOrigin = nil
                                    visibleCount = 6
                                    updateVisibleRecipes()
                                }) {
                                    // selected : unselected
                                    ProvinceButton(
                                        province: "ALL",
                                        textCol: selectedOrigin == nil ? "FFF9F0" : "C1B8AB",
                                        backCol: selectedOrigin == nil ? "F15533" : "EEE6DA",
                                        fontName: selectedOrigin == nil ? "Montserrat-SemiBold" : "Montserrat-Regular",
                                        image: selectedOrigin == nil ? "all-selected" : "all-unselected",
                                        imgPadding:60,
                                        paddingTop: 10
                                    )
                                }
                                
                                // 2. MARK: SHOW JAVA
                                Button(action: {
                                    selectedOrigin = "Java"
                                    visibleCount = 6
                                    updateVisibleRecipes()
                                }) {
                                    // selected : unselected
                                    ProvinceButton(
                                        province: "Java",
                                        textCol: selectedOrigin == "Java" ? "FFF9F0" : "C1B8AB",
                                        backCol: selectedOrigin == "Java" ? "F15533" : "EEE6DA",
                                        fontName: selectedOrigin == "Java" ? "Montserrat-SemiBold" : "Montserrat-Regular",
                                        image: selectedOrigin == "Java" ? "jawa-selected" : "jawa-unselected",
                                        imgPadding:60,
                                        paddingTop: 10
                                    )
                                }
                                
                                // 3. MARK: SHOW DKI Jakarta
                                Button(action: {
                                    selectedOrigin = "DKI Jakarta"
                                    visibleCount = 6
                                    updateVisibleRecipes()
                                }) {
                                    // selected : unselected
                                    ProvinceButton(
                                        province: "Jakarta",
                                        textCol: selectedOrigin == "DKI Jakarta" ? "FFF9F0" : "C1B8AB",
                                        backCol: selectedOrigin == "DKI Jakarta" ? "F15533" : "EEE6DA",
                                        fontName: selectedOrigin == "DKI Jakarta" ? "Montserrat-SemiBold" : "Montserrat-Regular",
                                        image: selectedOrigin == "DKI Jakarta" ? "jkt-selected" : "jkt-unselected",
                                        imgPadding:60,
                                        paddingTop: 10
                                    )
                                }
                                
                                
                                // 4. MARK: SHOW Yogyakarta
                                Button(action: {
                                    selectedOrigin = "Yogyakarta"
                                    visibleCount = 6
                                    updateVisibleRecipes()
                                }) {
                                    // selected : unselected
                                    ProvinceButton(
                                        province: "Yogya",
                                        textCol: selectedOrigin == "Yogyakarta" ? "FFF9F0" : "C1B8AB",
                                        backCol: selectedOrigin == "Yogyakarta" ? "F15533" : "EEE6DA",
                                        fontName: selectedOrigin == "Yogyakarta" ? "Montserrat-SemiBold" : "Montserrat-Regular",
                                        image: selectedOrigin == "Yogyakarta" ? "yogya-selected" : "yogya-unselected",
                                        imgPadding:60,
                                        paddingTop: 10
                                    )
                                }
                                
                                
                                // 5. MARK: SHOW Sumatra
                                Button(action: {
                                    selectedOrigin = "Sumatra"
                                    visibleCount = 6
                                    updateVisibleRecipes()
                                }) {
                                    // selected : unselected
                                    ProvinceButton(
                                        province: "Sumatra",
                                        textCol: selectedOrigin == "Sumatra" ? "FFF9F0" : "C1B8AB",
                                        backCol: selectedOrigin == "Sumatra" ? "F15533" : "EEE6DA",
                                        fontName: selectedOrigin == "Sumatra" ? "Montserrat-SemiBold" : "Montserrat-Regular",
                                        image: selectedOrigin == "Sumatra" ? "sumatera-selected" : "sumatera-unselected",
                                        imgPadding:60,
                                        paddingTop: 10
                                    )
                                }
                                
                                
                                // 6. MARK: SHOW Sulawesi
                                Button(action: {
                                    selectedOrigin = "Sulawesi"
                                    visibleCount = 6
                                    updateVisibleRecipes()
                                }) {
                                    // selected : unselected
                                    ProvinceButton(
                                        province: "Sulawesi",
                                        textCol: selectedOrigin == "Sulawesi" ? "FFF9F0" : "C1B8AB",
                                        backCol: selectedOrigin == "Sulawesi" ? "F15533" : "EEE6DA",
                                        fontName: selectedOrigin == "Sulawesi" ? "Montserrat-SemiBold" : "Montserrat-Regular",
                                        image: selectedOrigin == "Sulawesi" ? "sulawesi-selected" : "sulawesi-unselected",
                                        imgPadding:60,
                                        paddingTop: 10
                                    )
                                }
                                
                                
                                // 7. MARK: SHOW Bali
                                Button(action: {
                                    selectedOrigin = "Bali"
                                    visibleCount = 6
                                    updateVisibleRecipes()
                                }) {
                                    // selected : unselected
                                    ProvinceButton(
                                        province: "Bali",
                                        textCol: selectedOrigin == "Bali" ? "FFF9F0" : "C1B8AB",
                                        backCol: selectedOrigin == "Bali" ? "F15533" : "EEE6DA",
                                        fontName: selectedOrigin == "Bali" ? "Montserrat-SemiBold" : "Montserrat-Regular",
                                        image: selectedOrigin == "Bali" ? "bali-selected" : "bali-unselected",
                                        imgPadding:60,
                                        paddingTop: 10
                                    )
                                }
                                
                                
                                // 8. MARK: SHOW Jambi
                                Button(action: {
                                    selectedOrigin = "Jambi"
                                    visibleCount = 6
                                    updateVisibleRecipes()
                                }) {
                                    // selected : unselected
                                    ProvinceButton(
                                        province: "Jambi",
                                        textCol: selectedOrigin == "Jambi" ? "FFF9F0" : "C1B8AB",
                                        backCol: selectedOrigin == "Jambi" ? "F15533" : "EEE6DA",
                                        fontName: selectedOrigin == "Jambi" ? "Montserrat-SemiBold" : "Montserrat-Regular",
                                        image: selectedOrigin == "Jambi" ? "jambi-selected" : "jambi-unselected",
                                        imgPadding:60,
                                        paddingTop: 10
                                    )
                                }
                                
                                Spacer().frame(width: 0.0001) // ensures padding on first view
                                
                            }
                        }
                        .padding(.horizontal, -16) // remove original padding
                        
                        
                        
                        Spacer().frame(height: 32)
                        
                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)], spacing: 20) {
                            ForEach(visibleRecipes) { recipe in
                                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                    RecipeCard(
                                        thumbnailIMG: recipe.thumbnailIMG,
                                        name: recipe.name,
                                        origin: recipe.origin,
                                        level: recipe.level
                                    )
                                }
                            }
                        }
                        
                        Spacer().frame(height:32)
                        
                        if shouldShowViewMoreButton {
                            Button(action: {
                                visibleCount += 4
                                updateVisibleRecipes()
                            }) {
                                DefaultActiveButton(label: "View more recipes", backHex: "F15533", textHex: "fff")
                                    .padding(.horizontal, 32)
//                                Text("View More")
//                                    .foregroundColor(.blue)
//                                    .padding()
                            }
                        }
                        
                        Spacer().frame(height:2)
                        
                        // bottom padding
                        Spacer().frame(height: 84)
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
            }
            
            VStack {
                Spacer()
                // bottom sticky
            }
            .padding().padding(.bottom, 68)
        }
        
        .onAppear {
            apiRecipesCall().getRecipes { recipes in
                self.recipes = recipes
                updateVisibleRecipes()
            }
        }
    }
    
    private func updateVisibleRecipes() {
        if let selectedOrigin = selectedOrigin {
            visibleRecipes = recipes.filter { $0.origin == selectedOrigin }
        } else {
            visibleRecipes = Array(recipes.prefix(visibleCount))
        }
    }
    
    private var shouldShowViewMoreButton: Bool {
        if let selectedOrigin = selectedOrigin {
            return visibleRecipes.count < recipes.filter { $0.origin == selectedOrigin }.count
        } else {
            return visibleCount < recipes.count
        }
    }
}

// MARK: Explore Button
struct ProvinceButton: View {
    
    var province: String
    var textCol: String
    var backCol: String
    var fontName: String
    var image: String
    let imgPadding: CGFloat
    let paddingTop: CGFloat
    
    var body: some View {
        VStack {
            VStack{
                Spacer().frame(height: paddingTop)
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imgPadding)
            }

            Spacer()
            Text(province)
                .foregroundColor(Color(hex: textCol))
                .font(.custom(fontName, size: 14, relativeTo: .body))
        }
        .padding(8)
        .frame(width: 88, height: 88)
        .background(Color(hex: backCol))
        .cornerRadius(16)
    }
}

