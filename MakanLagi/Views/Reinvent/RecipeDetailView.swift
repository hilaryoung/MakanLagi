//
//  RecipeDetailView.swift
//  MakanLagi
//
//  Created by Hilary Young on 02/05/2023.
//

import SwiftUI

struct RecipeDetailView: View {
    
    let recipe: Recipe // Pass in the selected recipe as a parameter
    @State private var isShowingInstructions = true // track which view to show
    @State private var showAwardPopUp: Bool = false // Award popup
    @State var buttonClicked = false // Award claim condition
    
    // modal trial
    @State private var verticalSpacer: CGFloat = UIScreen.main.bounds.width/2.75
    
    var body: some View {
        VStack {
            ZStack{
                ScrollView(.vertical, showsIndicators: false) {
                    
                    // MARK: Cover image
                    GeometryReader{ reader in
                        AsyncImage(url: URL(string: recipe.coverIMG)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width)
                        } placeholder: {
                            ProgressView() // loader
                        }
                        .offset(y: -reader.frame(in: .global).minY)
                        // Parallax effect
                        //.frame(width: UIScreen.main.bounds.width, height: max(reader.frame(in: .global).minY + 300, 0))
                    }
                    .frame(height: 320)
                    .background(Color(hex: "FFF9F0"))
                    
                    // MARK: Recipe Detail
                    HStack {
                        VStack(alignment: .leading) {
                            
                            // MARK: Header
                            HStack{
                                VStack(alignment: .leading){
                                    Spacer().frame(height: 24)
                                    Text(recipe.name)
                                        .foregroundColor(Color(hex: "3A290E"))
                                        .font(.custom("PlayfairDisplay-Bold", size: 28, relativeTo: .title))
                                        .bold()
                                        .lineSpacing(2)
                                    Spacer().frame(height: 8)
                                    Text(recipe.origin)
                                        .foregroundColor(Color(hex: "71604A"))
                                        .font(.custom("Montserrat-Regular", size: 18, relativeTo: .title3))
                                }
                                Spacer()
                                VStack(alignment: .trailing){
                                    Button(action: {
                                        isShowingInstructions.toggle() // toggle the state to switch between views
                                    }) {
                                        configDetailButton(
                                            symbol: isShowingInstructions ? "NPinkKawung" : "NYellowKawung",
                                            color: isShowingInstructions ? "FBA8B7" : "319070"
                                        )
                                    }
                                }
                                
                            }
                            
                            Spacer().frame(height: 32)
                            
                            // MARK: CONTENT
                            if isShowingInstructions {
                                RecipeInstructionView(recipe: recipe) // show RecipeInstructionView
                                
                                Spacer().frame(height: 40)
                                // MARK: Complete recipe button
                                HStack {
                                    Spacer()
                                    if buttonClicked {
                                        Text("You've already claimed this award")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 14))
                                    } else {
                                        Button(action: {
                                            withAnimation {
                                                showAwardPopUp.toggle()
                                            }
                                            self.buttonClicked = true
                                        }) {
                                            DefaultActiveButton(label: "Complete Recipe", backHex: "F15533", textHex: "fff")
                                                .padding(.horizontal, 32)
                                        }
                                        .disabled(buttonClicked)
                                    }
                                    Spacer()
                                }
                                
                                Spacer().frame(height: 60)
                                
                            } else {
                                LearnRecipeView(recipe: recipe) // show LearnRecipeView
                            }
                            
                            Spacer() // VStack bottom spacer - ensure full width
                        }
                        .padding()
                        Spacer() // HStack trailing spacer - ensure full width
                    }
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity
                    )
                    .background(.white)
                    //.background(Color(hex: "FFF9F0"))
                    .cornerRadius(30)
                    .offset(y: -25)
                }
            }
        }
        .popupNavigationView(show: $showAwardPopUp, verticalSpacer: $verticalSpacer) {
            AwardPopUp(showAwardPopUp: $showAwardPopUp, itemName:"From Recipe", awardValue: Int.random(in: 0...11))
        }
    }
}



// VIEW 2: Recipe Instruction View
struct RecipeInstructionView: View {
    let recipe: Recipe
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                
                // MARK: Recipe details
                HStack{
                    VStack(alignment: .leading){
                        HStack{
                            Image(systemName: "clock.fill")
                            Text(recipe.formattedTime)
                                .font(.custom("Montserrat-SemiBold", size: 16, relativeTo: .body))
                                //.bold()
                        }
                        Spacer().frame(height: 4)
                        Text("Cook time")
                            .font(.custom("Montserrat-Regular", size: 14, relativeTo: .body))
                            .foregroundColor(Color(hex: "71604A"))
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading){
                        HStack{
                            Image(systemName: "lasso.and.sparkles")
                            Text(recipe.level)
                                .font(.custom("Montserrat-SemiBold", size: 16, relativeTo: .body))
                        }
                        Spacer().frame(height: 2)
                        Text("Level")
                            .font(.custom("Montserrat-Regular", size: 14, relativeTo: .body))
                            //.font(.system(size: 14))
                            .foregroundColor(Color(hex: "71604A"))
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading){
                        HStack{
                            Image(systemName: "fork.knife")
                            Text("\(recipe.serving)")
                                .font(.custom("Montserrat-SemiBold", size: 16, relativeTo: .body))
                        }
                        Spacer().frame(height: 2)
                        Text("Serving")
                            .font(.custom("Montserrat-Regular", size: 14, relativeTo: .body))
                            .foregroundColor(Color(hex: "71604A"))
                    }
                }
                
                Spacer().frame(height: 32)
                
                // MARK: Ingredients
                VStack(alignment: .leading){
                    Text("Ingredients")
                        .font(.custom("Montserrat-Regular", size: 20, relativeTo: .title3))
                        .foregroundColor(Color(hex: "3A290E"))
                        .bold()
                        //.font(.title3).bold()
                    Spacer().frame(height: 16)
                    
                    // Iterate list of Ingredients
                    ForEach(recipe.ingredients, id: \.self) { ingredient in
                        HStack{
                            Circle().fill(Color(hex: "F15533")).frame(width: 8, height: 8)
                            Text("\(ingredient.quantity) \(ingredient.measurement) \(ingredient.name)")
                                .font(.custom("Montserrat-Regular", size: 16, relativeTo: .body))
                        }
                        Spacer().frame(height: 12)
                    }
                }
                
                
                Spacer().frame(height: 8)
                
                
                // Component 3: Steps
                VStack(alignment: .leading){
                    Spacer().frame(height: 32)
                    Text("Steps")
                        .foregroundColor(Color(hex: "3A290E"))
                        .font(.custom("Montserrat-Regular", size: 20, relativeTo: .title3))
                        .bold()
                        //.font(.title3).bold()
                    Spacer().frame(height: 16)
                    
                    // Iterate each steps
                    ForEach(recipe.steps.indices, id: \.self) { index in
                        HStack(alignment: .top) {
                            Text("\(index + 1).")
                                .font(.custom("Montserrat-Regular", size: 20, relativeTo: .body))
                                .bold()
                                .foregroundColor(Color(hex: "F15533"))
                            Text("\(recipe.steps[index])")
                                .font(.custom("Montserrat-Regular", size: 16, relativeTo: .body))
                                .lineSpacing(4)
                        }
                        Spacer().frame(height: 12)
                    }
                    
                }
                
                
                // Component 4: Credit
                VStack(alignment: .leading){
                    Spacer().frame(height: 32)
                    Text("Recipe by")
                        .foregroundColor(Color(hex: "3A290E"))
                        .font(.custom("Montserrat-Regular", size: 16, relativeTo: .body))
                        .bold()
                    Spacer().frame(height: 8)
                    
                    // Iterate each steps
                    Link(destination: URL(string: recipe.credLink)!) {
                        HStack{
                            Image(systemName: "link")
                            Text(recipe.author)
                                .font(.custom("Montserrat-Regular", size: 16, relativeTo: .body))
                        }
                    }
                    
                    
                    
                }
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }
}





// VIEW 3: Learn View
struct LearnRecipeView: View {
    let recipe: Recipe
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                
                // Component 1: Location
//                VStack(alignment: .leading){
//                    Text("All the way from...")
//                        .font(.custom("Montserrat-Regular", size: 20, relativeTo: .title3))
//                        .foregroundColor(Color(hex: "3A290E"))
//                        .bold()
//                    Spacer().frame(height: 16)
//                    AsyncImage(url: URL(string: recipe.mapImg)) { image in
//                        image.resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .cornerRadius(8)
//                    } placeholder: {
//                        Spacer().frame(height: 16)
//                        HStack{
//                            Spacer()
//                            ProgressView() // loader
//                            Spacer()
//                        }
//                        Spacer().frame(height: 16)
//                    }
//                }
//
//                Spacer().frame(height: 8)
//
                
                // Component 2: Fun fact...
                VStack(alignment: .leading){
                    //Spacer().frame(height: 32)
                    Text("Fun fact...")
                        .font(.custom("Montserrat-Regular", size: 20, relativeTo: .title3))
                        .foregroundColor(Color(hex: "3A290E"))
                        .bold()
                    Spacer().frame(height: 8)
                    Text(recipe.funFact)
                        .font(.custom("PlayfairDisplay-BoldItalic", size: 24, relativeTo: .title3))
                        .bold()
                        .foregroundColor(Color(hex: "F15533"))
                        .lineSpacing(4)
                }
                
                Spacer().frame(height: 8)
                
                // Component 3: History...
                VStack(alignment: .leading){
                    Spacer().frame(height: 32)
                    Text("History")
                        .font(.custom("Montserrat-Regular", size: 20, relativeTo: .title3))
                        .foregroundColor(Color(hex: "3A290E"))
                        .bold()
                    Spacer().frame(height: 16)
                    Text(recipe.history)
                        .font(.custom("Montserrat-Regular", size: 16, relativeTo: .body))
                        .lineSpacing(4)
                }
                
                
                Spacer().frame(height: 68)
                
                // MARK: END indicator
                HStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(hex:"E5DCCE"))
                        .frame(width: 70, height: 4)
                    Spacer()
                }
                Spacer().frame(height: 36)
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }
}









struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}



func configDetailButton2(symbol: String) -> some View {
    ZStack {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color(hex: "947E61"))
            .frame(width: 48, height: 48)
            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 4)
        Image(systemName: symbol)
            .resizable()
            .foregroundColor(.white)
            .frame(width: 18, height: 18)
    }
}

func configDetailButton(symbol: String, color: String) -> some View {
    ZStack {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color(hex: color))
            .frame(width: 56, height: 56)
            //.shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 2)
        
        Image(symbol)
            .resizable()
            .frame(width: 56, height: 56)
    }
    .frame(width: 56, height: 56)
    .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 2)
}









//struct RecipeDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeDetailView()
//    }
//}
