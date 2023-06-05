//
//  RecipeListView.swift
//  MakanLagi
//
//  Created by Hilary Young on 02/05/2023.
//

import SwiftUI

struct RecipeListView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State public var selectedIngredients: [Ingredient]
    
    @State private var recipes: [Recipe] = [] // Store fetched recipes in a @State property
    
    var body: some View {
        ZStack{
            Color(hex: "FFF9F0").edgesIgnoringSafeArea(.all) // background color
            
            ScrollView {
                VStack(alignment: .leading){
                    
                    // MARK: Header
                    Group{
                        Spacer().frame(height: 12)
                        Text("Find recipes")
                            .font(.custom("PlayfairDisplay-Bold", size: 28, relativeTo: .title))
                            .foregroundColor(Color(hex: "3A290E"))
                            .fontWeight(.bold)
                        Spacer().frame(height: 8)
                        Text("Reinvent your meal with:")
                            .font(.custom("Montserrat-Regular", size: 18, relativeTo: .title3))
                        Spacer().frame(height: 16)
                    }
                    
                    
                    // MARK: Selected Ingredients
                    VStack(alignment: .leading) {
                        //Text("Selected ingredients:")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(selectedIngredients, id: \.self) { ingredient in
                                    HStack {
                                        Text(ingredient.enName)
                                            .foregroundColor(Color(hex: "71604A"))
                                        Button(action: {
                                            if selectedIngredients.count > 1 {
                                                selectedIngredients.removeAll { $0 == ingredient }
                                            }
                                        }) {
                                            Image(systemName: "xmark")
                                                .foregroundColor(Color(hex: "71604A"))
                                                .opacity(selectedIngredients.count > 1 ? 1.0 : 0.5)
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 12)
                                    //.padding(.horizontal, 16)
                                    //.padding(.vertical, 8)
                                    .background(Color(hex: "E5DCCE"))
                                    .cornerRadius(100)
                                }
                            }
                        }
                    }
                    
                    
                    
                    
                    Spacer().frame(height: 32)
                    
                    
                    // MARK: Recipe list (GRID)
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)], spacing: 20) {
                        ForEach(filterRecipes(recipes, by: selectedIngredients) ) { recipe in
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
                    
                    
                    
                    // Component 4: Condition, when no recipes found
                    if filterRecipes(recipes, by: selectedIngredients).isEmpty {
                        Text("No recipes found")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    
                    
                    
                    Spacer().frame(height: 100)
                    
                    // dont delete beyond here
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            VStack {
                Spacer()
            }
            .padding()
            
        }
        
        .onAppear {
            apiRecipesCall().getRecipes { recipes in
                self.recipes = recipes // Update the @State property with fetched recipes
            }
        }
    }
}




func filterRecipes(_ recipes: [Recipe], by selectedIngredients: [Ingredient]) -> [Recipe] {
    return recipes.filter { recipe in
        // Use contains(where:) to check if any ingredient name matches any selected ingredient
        selectedIngredients.allSatisfy { selected in
            recipe.ingredients.contains { ingredient in
                selected.enName == ingredient.name
            }
        }
    }
}








//struct RecipeListView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeListView()
//    }
//}
