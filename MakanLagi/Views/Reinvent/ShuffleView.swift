//
//  ShuffleView.swift
//  MakanLagi
//
//  Created by Hilary Young on 02/05/2023.
//

import SwiftUI

struct ShuffleView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.presentationMode) var presentationMode
    
    let selectedItemName: String
    
    @State var ingredients: [Ingredient] = [] // store json
    @State private var selectedIngredients: [Ingredient] = []
    
    @State var prefixCount = 2 // amount of ingredients shown first
    
    let gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())] // grid
    
    let columns2 = Array(repeating: GridItem(.flexible(), spacing: 16), count: 2)
    
    var body: some View {
        ZStack{
            Color(hex: "FFF9F0").edgesIgnoringSafeArea(.all) // background color
            
            ScrollView {
                VStack(alignment: .leading){
                    
                    // MARK: Header
                    Group{
                        Spacer().frame(height: 12)
                        Text("Reinventing")
                            .font(.custom("PlayfairDisplay-Bold", size: 28, relativeTo: .title))
                            .foregroundColor(Color(hex: "3A290E"))
                            .fontWeight(.bold)
                        Spacer().frame(height: 8)
                        Text("\(selectedItemName) with native spices...")
                            .font(.custom("Montserrat-Regular", size: 18, relativeTo: .title3))
                        Spacer().frame(height: 42)
                    }
                    
                    
                    // MARK: Ingredient Shuffler
                    LazyVGrid(columns: columns2, spacing: 16) {
                        ForEach(0..<4) { index in
                            ZStack {
                                VStack{
                                    Color(hex: "EEE6DA")
                                        .cornerRadius(16)
                                }
                                .frame(maxWidth: .infinity)
                                .aspectRatio(1, contentMode: .fit)
                                //.cornerRadius(16)
                                
                                // MARK: Ingredient content
                                if index < selectedIngredients.count {
                                    VStack{
                                        // Border
                                        ZStack{
                                            Color(.white)
                                                .cornerRadius(10)
                                                .padding(8)
                                            
                                            // Content
                                            VStack{
                                                // Image
                                                AsyncImage(url: URL(string: selectedIngredients[index].ingIMG)) { image in
                                                    image.resizable()
                                                } placeholder: {
                                                    ProgressView() // image placeholder
                                                }
                                                .frame(width: 85, height: 85)
                                                
                                                Spacer().frame(height:12)
                                                
                                                // English Name
                                                Text(selectedIngredients[index].enName)
                                                    .foregroundColor(Color(hex: "3A290E"))
                                                    .font(.custom("Montserrat-SemiBold", size: 16, relativeTo: .body))
                                                    .lineLimit(1)
                                                    .padding(.horizontal, 8)
                                                
                                                Spacer().frame(height:4)
                                                
                                                // Indonesian Name
                                                Text(selectedIngredients[index].idName)
                                                    .foregroundColor(Color(hex: "3A290E").opacity(0.5))
                                                    .font(.custom("Montserrat-Regular", size: 12, relativeTo: .caption))
                                                    .lineLimit(1)
                                                    .padding(.horizontal, 8)
                                            }
                                        }
                                        .frame(maxWidth: .infinity)
                                        .aspectRatio(1, contentMode: .fit)
                                        
                                    }
                                    
                                }
                            }
                        }
                    }
                    
                    
                    Spacer().frame(height:28)
                    
                    
                    
                    // MARK: Buton configuration
                    HStack{
                        Spacer()
                        // MARK: DELETE Button
                        Button(action: {
                            if prefixCount > 1 {
                                prefixCount -= 1
                                selectedIngredients.removeLast()
                            }
                        }, label: {
                            removeIngButton()
                        })
                        
                        Spacer().frame(width: 16)
                        
                        // MARK: SHUFFLE Button
                        Button(action: {
                            selectedIngredients = Array(ingredients.shuffled().prefix(prefixCount))
                        }) {
                            shuffleButton()
                        }
                        
                        Spacer().frame(width:16)
                        
                        // MARK: ADD Button
                        Button(action: {
                            if prefixCount < selectedIngredients.count && prefixCount < 4 {
                                prefixCount += 1
                            } else if prefixCount < ingredients.count && prefixCount < 4 {
                                prefixCount += 1
                                if prefixCount <= selectedIngredients.count {
                                    selectedIngredients.removeLast()
                                    selectedIngredients.append(ingredients[prefixCount - 1])
                                } else {
                                    selectedIngredients.append(ingredients[prefixCount - 1])
                                }
                            }
                        }, label: {
                            //configIngButton(symbol: "sharpAdd")
                            addIngButton()
                        })
                        
                        Spacer()
                    }
                    
                    Spacer().frame(height: 16)
                    
                    
                    
                    // MARK: Continue button
                    
                    HStack{
                        Spacer()
                        NavigationLink(
                            destination: RecipeListView(selectedIngredients: selectedIngredients)
                        ){
                            confirmIngButton()
                        }
                        Spacer()
                    }
                    
                    
                    
                    Spacer().frame(height: 68)
                    
                    
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .onAppear {
                    apiIngredientsCall().getIngredients { (ingredients) in
                        self.ingredients = ingredients
                        self.selectedIngredients = Array(self.ingredients.shuffled().prefix(self.prefixCount))
                    }
                }
            }
            
        }
    }
}



struct configIngButton: View {
    var symbol: String
    
    // systemName: "plus"
    // systemName: "minus"
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(hex: "EEE6DA"))
                .frame(width: 44, height: 44)
            Image(systemName: symbol)
                .foregroundColor(Color(hex: "947E61"))
                .font(.system(size: 21, weight: .bold))
        }
    }
}

struct addIngButton: View {
    
    // systemName: "plus"
    // systemName: "minus"
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(hex: "EEE6DA"))
                .frame(width: 44, height: 44)
            Image("sharpAdd")
                .resizable()
                .frame(width:18, height: 18)
                .foregroundColor(Color(hex: "947E61"))
        }
    }
}

struct removeIngButton: View {
    
    // systemName: "plus"
    // systemName: "minus"
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(hex: "EEE6DA"))
                .frame(width: 44, height: 44)
            Image("sharpRemove")
                .resizable()
                .frame(width:18, height: 18)
                .foregroundColor(Color(hex: "947E61"))
        }
    }
}


struct shuffleButton: View {
    
    // systemName: "plus"
    // systemName: "minus"
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(hex: "F15533"))
                .frame(width: 56, height: 56)
            Image(systemName: "gobackward")
                .foregroundColor(Color(hex: "fff"))
                .font(.system(size: 21, weight: .bold))
        }
    }
}

struct confirmIngButton: View {
    
    var body: some View {
        VStack{
            HStack {
                Text("Confirm ingredients")
                    .foregroundColor(Color(hex: "947E61"))
                    .font(.custom("Montserrat-SemiBold", size: 16, relativeTo: .body))
                
                Image(systemName: "chevron.right")
                    .foregroundColor(Color(hex: "947E61"))
            }
        }
        .padding()
        .background(Color(hex: "EEE6DA"))
        .cornerRadius(1000)
        
    }
}



//struct ShuffleView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShuffleView()
//    }
//}





