//
//  HomeView.swift
//  MakanLagi
//
//  Created by Hilary Young on 02/05/2023.
//

import SwiftUI

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @State private var searchText: String = ""
    
    @State private var recipes: [Recipe] = []
    
    var body: some View {
        ZStack{
            Color(hex: "FFFAF3").edgesIgnoringSafeArea(.all) // background
            
            ScrollView{
                //HomeBackground()
                ZStack{
                    VStack(alignment: .leading){
                        
                        
                        Group{
                            Spacer().frame(height: 56)
                            if let user = viewModel.users.first {
                                Text("Welcome, \(user.firstName)")
                                    .font(.custom("Montserrat-Regular", size: 18, relativeTo: .title3))
                            } else {
                                Text("Welcome,")
                                    .font(.custom("Montserrat-Regular", size: 18, relativeTo: .title3))
                            }
                            Spacer().frame(height: 4)
                            Text("Lets get cooking.")
                                .font(.custom("PlayfairDisplay-Bold", size: 32, relativeTo: .largeTitle))
                                .foregroundColor(Color(hex: "3A290E"))
                            Spacer().frame(height: 42)
                        }
                        
                        
                        // MARK: Search Bar
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color(hex: "5B4D38"))
                            TextField("Search for leftover...", text: $searchText)
                                .foregroundColor(Color(hex: "5B4D38"))
                                .autocapitalization(.none)
                        }
                        .padding()
                        .background(Color(hex: "E5DCCE"))
                        .cornerRadius(100)
                        .onTapGesture {
                            // Dismiss keyboard when tapped outside the search bar
                            hideKeyboard()
                        }
                        
                        
                        Spacer().frame(height: 32)
                        
                        
                        // MARK: Reinventing Kit
                        Group{
                            ReinventingKitButton()
                            Spacer().frame(height: 20)
                        }
                        
                        // MARK: Awards and Explore
                        Group{
                            HStack{
                                NavigationLink {
                                    AwardsListView() // destination
                                } label: {
                                    AwardsButton() // button
                                }
                                
                                Spacer().frame(width:20)
                                
                                NavigationLink {
                                    //AwardsListView() // destination
                                    ExploreView()
                                } label: {
                                    ExploreButton() // button
                                }
                            }
                            
                            Spacer().frame(height: 32)
                        }
                        
                    
                        Text("Popular Recipes")
                            //.font(.title3)
                            .font(.custom("Montserrat-Regular", size: 18, relativeTo: .title3))
                            .bold()
                            .foregroundColor(Color(hex: "3A290E"))
                            .padding(.bottom,8)
                        
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                Spacer().frame(width: 0.0001) // ensures padding on first view
                                ForEach(recipes.prefix(3)) { recipe in // show first 3 items
                                    NavigationLink {
                                        RecipeDetailView(recipe: recipe)
                                    } label: {
                                        VStack(alignment: .leading, spacing: 6){
                                            
                                            ZStack{
                                                VStack{
                                                    AsyncImage(url: URL(string: recipe.thumbnailIMG)) { image in
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
                                            .overlay(
                                                Text(recipe.level)
                                                    .foregroundColor(.white)
                                                    .font(.custom("Montserrat-Regular", size: 14, relativeTo: .caption))
                                                    .padding(.horizontal, 12)
                                                    .padding(.vertical, 8)
                                                    // custom corners
                                                    .background(RoundedCorners(
                                                        color: getColor(for: recipe.level),
                                                        tl: 30, tr: 0, bl: 30, br: 0))
                                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                                    .padding(.bottom,10)
                                                , alignment: .bottomTrailing
                                            )
                                            
                                            Spacer().frame(height:2)
                                            
                                            Text(recipe.name)
                                                .foregroundColor(Color(hex: "3A290E"))
                                                .font(.custom("Montserrat-SemiBold", size: 16, relativeTo: .body))
                                                //.bold()
                                                .lineLimit(1)
                                                .padding(.horizontal, 8)
                                            
                                            Text(recipe.origin)
                                                .foregroundColor(Color(hex: "3A290E").opacity(0.7))
                                                .font(.custom("Montserrat-Regular", size: 12, relativeTo: .caption))
                                                .font(.system(size:12)) // list view 14x
                                                .lineLimit(1)
                                                .padding(.horizontal, 8)
                                            
                                            Spacer().frame(height:8)
                                        }
                                        .frame(width: UIScreen.main.bounds.width / 2.6)
                                        .background(Color.white)
                                        .cornerRadius(16)
                                    }
                                }
                                .shadow(color: Color.black.opacity(0.06), radius: 5, x: 0, y: 5)
                                
                                Spacer().frame(width: 0.0001)// ensures padding on first view
                            }
                            .padding(.bottom,16)
                        }
                        .padding(.horizontal, -16) // remove original padding
                        
                        
                        
                        
                        
                        Spacer().frame(height: 32)
                        
                        // MARK: End of page indicator
                        HStack {
                            Spacer()
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(hex:"E5DCCE"))
                                .frame(width: 70, height: 4)
                            Spacer()
                        }
                        Spacer().frame(height: 65)

                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    
                    
                }
            }
        }
        .onAppear {
            apiRecipesCall().getRecipes { recipes in
                self.recipes = recipes // Update the @State property with fetched recipes
            }
            viewModel.fetchUserName()
        }
    }
}



// MARK: Home Background on ZStack level (Scrollable)
struct HomeBackground: View {
    
    var body: some View {
        GeometryReader { geo in
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color(hex: "E5DCCE"))
                .frame(width: geo.size.width, height: 700)
                .offset(y: -480)
        }
    }
}


// MARK: Reinvent Kit button
struct ReinventingKitButton: View {
    var body: some View {
        ZStack(alignment: .leading) {
            GeometryReader { geometry in
                // Adjust the padding to 0
                HStack(alignment: .top) {
                }
                .padding(.top, 0)
                .padding(.horizontal, 0)
                .frame(width: geometry.size.width)
                .clipped()
                
                
                HStack(alignment: .top) {
                    Spacer()
                    Image("Nyonya")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width/2.3)
                        .padding(.top, 0)
                        .padding(.horizontal, 0)
                }
                .padding(.top, 0)
                .padding(.horizontal, 0)
                .frame(width: geometry.size.width)
                .clipped()
                
                VStack(alignment: .leading) {
                    Spacer()
                    
                    Text("Start Inventing")
                    //Text("Ayo masak!")
                        .foregroundColor(.white)
                        .font(.custom("Montserrat-Regular", size: 18, relativeTo: .title3))
                        .bold()
                    
                    Spacer().frame(height: 16)
                    
                    NavigationLink {
                        ReinventingKitView() // destination
                    } label: {
                        SmallNextButton(label: "View kit")
                    }
                    
                }
                .padding(16).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            .padding(.horizontal, 0)
        }
        .foregroundColor(Color(hex: "947E61"))
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .frame(height: 168-32+24)
        .background(Color(hex: "E49E02"))
        .cornerRadius(16)
    }
}



// MARK: Awards Button
struct AwardsButton: View {
    var body: some View {
        ZStack(alignment: .leading) {
            GeometryReader { geometry in
                HStack(alignment: .top) {
                    Spacer()
                    Image("DoublePinkKawung")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: geometry.size.height/1.30) // Set height based on geometry size
                }
                .padding(.top, 0)
                
                VStack(alignment: .leading) {
                    Spacer()
                    
                    Text("Awards")
                        .foregroundColor(.white)
                        .font(.custom("Montserrat-Regular", size: 18, relativeTo: .title3))
                        .bold()
                }
                .padding(16)
            }
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .frame(height: 112)
        .background(Color(hex: "F56C30"))
        .cornerRadius(16)
    }
}


// MARK: Explore Button
struct ExploreButton: View {
    var body: some View {
        ZStack(alignment: .leading) {
            GeometryReader { geometry in
                HStack(alignment: .top) {
                    Spacer()
                    Image("NYellowKawung")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: geometry.size.height/1.35) // Set height based on geometry size
                    Spacer().frame(width: 8)
                }
                .padding(.top, 8)
                
                VStack(alignment: .leading) {
                    Spacer()
                    
                    Text("Explore")
                        .foregroundColor(.white)
                        .font(.custom("Montserrat-Regular", size: 18, relativeTo: .title3))
                        .bold()
                }
                .padding(16)
            }
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .frame(height: 112)
        .background(Color(hex: "319070"))
        .cornerRadius(16)
    }
}






struct DetailView: View {
    @EnvironmentObject var viewModel: AppViewModel
    var body: some View {
        ZStack{
            
            Color(hex: "FFF9F0")
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .leading){
                    
                    // MARK: Header
                    Text("Dashboard")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("Dashboard description")
                        .font(.body)
                        .padding(.bottom,24)
                    
                    
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
    }
}
