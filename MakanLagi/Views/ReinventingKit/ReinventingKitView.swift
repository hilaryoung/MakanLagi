//
//  ReinventingKitView.swift
//  MakanLagi
//
//  Created by Hilary Young on 07/05/2023.
//

import SwiftUI

struct ReinventingKitView: View {
    
    @State private var isShowingAddSheet = false
    @EnvironmentObject var viewModel: AppViewModel
    
    // Recipe
    @State private var recipes: [Recipe] = [] // Store fetched recipes in a @State property'
    
    let kitIngredients: [(String, [String])] = [
        ("KC001", ["Tamarind", "Palm sugar", "Candlenut"]),
        ("KC002", ["Cardamom", "Andaliman", "Nutmeg"]),
        ("KC003", ["Red chili pepper", "Candlenut", "Nutmeg"])
    ]
    
    
    
    var body: some View {
        ZStack{
            Color(hex: "FFF9F0").edgesIgnoringSafeArea(.all) // background color
            ScrollView {
                ZStack{
                    //KitBackground()
                    VStack(alignment: .leading){
                        
                        Group{
                            Text("Your kit.")
                                .font(.custom("PlayfairDisplay-Bold", size: 32, relativeTo: .largeTitle))
                                .foregroundColor(Color(hex: "3A290E"))
                            Spacer().frame(height: 16)
                        }
                        
                        Spacer().frame(height: 8)
                        
                        // MARK: CARD CODE
                        VStack(alignment: .leading){
                            ZStack{
                            
                                if viewModel.userKitCode.isEmpty {
                                    kitCardBackgroundEmpty()
                                } else {
                                    kitCardBackgroundDefault()
                                }
                                
                                VStack(alignment: .leading){
                                    Spacer()
                                    if viewModel.userKitCode.isEmpty {
                                        // MARK: USER DOES NOT HAVE CODE
                                        Button(action: {
                                            isShowingAddSheet = true
                                        }) {
                                            HStack{
                                                addKitButton(label: "Add your starter kit")
                                                Spacer()
                                            }
                                            
                                        }
                                    } else{
                                        HStack{
                                            Text(viewModel.userKitCode)
                                            Spacer()
                                            Button(action: {
                                                isShowingAddSheet = true
                                            }) {
                                                Image(systemName: "pencil")
                                                    .resizable()
                                                    .frame(width: 20, height: 20)
                                                    .foregroundColor(Color(hex: "3A290E"))
                                            }
                                        }
                                        .padding()
                                        .background(Color(hex: "E5DCCE"))
                                        .cornerRadius(8)
                                    }
                                    // end of card content
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .topLeading)
                            }
                            // end of card content
                        }
                        .frame(maxWidth: .infinity, alignment: .topLeading).frame(height: 240)
                        .background(Color(hex: "E5DCCE"))
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.06), radius: 5, x: 0, y: 4)
                        
                        
                        
                        
                        Spacer().frame(height: 40)
                        
                        // MARK: STARTER KIT CONTENT, WITHOUT CODE
                        if viewModel.userKitCode.isEmpty {
                            HStack{
                                Spacer()
                                VStack{
                                    Text("OR")
                                        .font(.title3)
                                        .bold()
                                    Spacer().frame(height: 16)
                                    Button(action: {
                                        UIApplication.shared.open(URL(string: "https://www.makanlagi.site")!)
                                    }, label: {
                                        GetKitButton()
                                    })
                                }
                                Spacer()
                            }
                        }
                        
                        // MARK: STARTER KIT CONTENT, WITH CODE
                        else {
                            
                            Text("Reinvent with your kit")
                                .font(.system(size: 20))
                                .bold()
                                .padding(.bottom,16)
                            
                            // MARK: Recipe Box List
                            // Find the corresponding tuple for the current kit code
                            if let userIngredients = kitIngredients.first(where: { $0.0 == viewModel.userKitCode })?.1 {

                                // Store the ingredients associated with the kit code in a variable
                                let newUserIngredients = userIngredients
                                
                                LazyVGrid(columns: [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)], spacing: 20) {
                                    // Show recipes that have at least one ingredient in newUserIngredients
                                    ForEach(recipes.filter { recipe in
                                        recipe.ingredients.contains(where: { ingredient in
                                            newUserIngredients.contains(ingredient.name)
                                        })
                                    }) { recipe in
                                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                            VStack(alignment: .leading, spacing: 8) {
                                                // recipe card
                                                RecipeCard(
                                                    thumbnailIMG: recipe.thumbnailIMG,
                                                    name: recipe.name,
                                                    origin: recipe.origin,
                                                    level: recipe.level
                                                )
                                            }
                                        }
                                    }
                                }
                                // end of recipes
                            }
                        }
                        Spacer().frame(height: 100)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
            }
        }
        // MARK: Sheet configurations
        .sheet(isPresented: $isShowingAddSheet) {
            AddStarterKitView()
        }
        
        // MARK: RETRIEVING DATA
        .onAppear {
            viewModel.fetchFirstKitCode()
            
            apiRecipesCall().getRecipes { recipes in
                self.recipes = recipes // Update the @State property with fetched recipes
            }
        }
    }
}



struct kitCardBackgroundEmpty: View {

    var body: some View {
        Color(hex: "319070").edgesIgnoringSafeArea(.all) // background color
        
        GeometryReader { geo in
            HStack{
                Spacer()
                
                Image("NYellowKawung")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geo.size.width/2)
                    .padding(.top, -30)
                    .padding(.horizontal, -30)
            }
        }
    }
}

struct kitCardBackgroundDefault: View {
    var body: some View {
        Color(hex: "E5DCCE").edgesIgnoringSafeArea(.all) // background color
        
        VStack(spacing: 0) {
            
            VStack(spacing: 0){
                GeometryReader { geo in
                    VStack(spacing: 0){
                        // first row
                        HStack(spacing: 0){
                            ForEach(0..<8) { _ in
                                return Image("NPinkKawung")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geo.size.height/2, height: geo.size.height/2)
                            }
                        }
                        .offset(x:-(geo.size.height/2)/2)
                        
                        // second row
                        HStack(spacing: 0){
                            ForEach(0..<8) { _ in
                                return Image("NPinkKawung")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geo.size.height/2, height: geo.size.height/2)
                            }
                        }
                        .offset(x:-(geo.size.height/2)/2)
                    }
                    .padding(0)
                }
            }
            .background(Color(hex: "FBA8B7"))
            .padding(0)
            
            
            // content VStack
            VStack {
                Color(hex: "319070")
            }
            .frame(height:68+16+8)
        }
    }
}






// MARK: Default [active]
struct addKitButton: View {
    var label: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.custom("Montserrat-SemiBold", size: 16, relativeTo: .body))
            Image(systemName: "chevron.right")
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 16)
        .foregroundColor(.white)
        .background(Color(hex: "3A290E"))
        .cornerRadius(100)
    }
}





struct KitBackground: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var isShowingAddSheet = false // Trigger PantryFormView sheet
    
    var body: some View {
        GeometryReader { geo in
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color(hex: "E5DCCE"))
                .frame(width: geo.size.width, height: 700)
                .offset(y: -480)
        }
    }
}


struct GetKitButton: View {
    var body: some View {
        Text("Get yours now!")
            .font(.custom("Montserrat-SemiBold", size: 16, relativeTo: .body))
            .foregroundColor(Color(hex: "947E61"))
            .padding(.horizontal,32).padding(.vertical,14)
            .background(Color(hex: "EEE6DA"))
            .cornerRadius(1000)
            .shadow(color: Color.black.opacity(0.06), radius: 5, x: -4, y: 4)
    }
}




struct RecipeCard: View {
    var thumbnailIMG: String
    var name: String
    var origin: String
    var level: String
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            ZStack{
                VStack{
                    AsyncImage(url: URL(string: thumbnailIMG)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                //overlay
                VStack{
                    Rectangle()
                        .foregroundColor(Color(hex: "3A290E").opacity(0.25))
                }
                
            }
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
            // how to round only the two left corner of this text?
            .overlay(
                Text(level)
                    .foregroundColor(.white)
                    .font(.custom("Montserrat-Regular", size: 14, relativeTo: .caption))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    // custom corners
                    .background(RoundedCorners(
                        color: getColor(for: level),
                        tl: 30, tr: 0, bl: 30, br: 0))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.bottom,10)
                , alignment: .bottomTrailing
            )
        
            
            Spacer().frame(height:2)
            
            // Item 2: Recipe Name
            Text(name)
                .foregroundColor(Color(hex: "3A290E"))
                .font(.custom("Montserrat-SemiBold", size: 16, relativeTo: .body))
                //.font(.system(size: 16))
                //.bold()
                .foregroundColor(.black)
                .padding(.horizontal, 8)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .truncationMode(.tail)
            
            // Item 3: Recipe Origin
            Text(origin)
                .foregroundColor(Color(hex: "3A290E").opacity(0.7))
                .font(.custom("Montserrat-Regular", size: 12, relativeTo: .caption))
                //.font(.system(size: 14))
                //.foregroundColor(Color(hex: "71604A"))
                .padding(.horizontal, 8)
                .multilineTextAlignment(.leading)
                .lineLimit(1)
                .truncationMode(.tail)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.06), radius: 5, x: 0, y: 5)
        
        
    }
}




//struct ReinventingKitView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReinventingKitView()
//    }
//}
