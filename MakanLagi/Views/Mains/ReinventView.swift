//
//  ReinventView.swift
//  MakanLagi
//
//  Created by Hilary Young on 02/05/2023.
//

import SwiftUI

struct ReinventView: View {

    @EnvironmentObject var viewModel: AppViewModel
    @State private var searchText: String = ""

    var body: some View {
        ZStack{
            Color(hex: "FFF9F0").edgesIgnoringSafeArea(.all) // background color
            ScrollView {
                ZStack{
                    ReinventBackground()
                    VStack(alignment: .leading){

                        // MARK: Header
                        Group{
                            Spacer().frame(height: 56)
                            Text("Time to reinvent")
                                .font(.custom("PlayfairDisplay-Bold", size: 28, relativeTo: .title))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                            Spacer().frame(height: 8)
                            Text("Select your leftovers to cook...")
                                .font(.custom("Montserrat-Regular", size: 18, relativeTo: .title3))
                                .foregroundColor(.white)
                            
                            Spacer().frame(height: 42)
                            Spacer().frame(height: 1)
                        }

                        // MARK: Search bar
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

                        
                        Spacer().frame(height: 16) // edge of banner
                        Spacer().frame(height: 24) // Spacing from edge of banner to top
                        
                        // MARK: Reinvent Leftover Card
                        if viewModel.leftovers.isEmpty {
                            EmptyPantryView()
                        } else {
                            ForEach(viewModel.leftovers.filter { searchText.isEmpty || $0.itemName.localizedCaseInsensitiveContains(searchText) }
                                    .sorted { abs($0.expDate.timeIntervalSinceNow) < abs($1.expDate.timeIntervalSinceNow) },
                                    id: \.id) { leftover in
                                
                                reinventLOCard(leftoverName: leftover.itemName, tagColor: leftover.expDate)
                                
                            }
                            
                            // MARK: End content
                            Spacer().frame(height:24)
                            HStack {
                                Spacer()
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(hex:"E5DCCE"))
                                    .frame(width: 70, height: 4)
                                Spacer()
                            }
                            Spacer().frame(height: 65)
                        }

                        
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
            }
            // All the sticky elements:
            VStack {
                Spacer()
                if viewModel.leftovers.isEmpty {
                    
                    Spacer().frame(height: 24)
                    
                    HStack{
                        Spacer()
                        NavigationLink(destination: ShuffleView(selectedItemName:"")) {
                            MediumNextButton(label: "Continue anyway")
                        }
                    }
                }
                
            }
            .padding().padding(.bottom,68)

        }

        // Fetch user data
        .onAppear {
            viewModel.fetchLeftovers()
        }
    }
}



struct reinventLOCard: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var leftoverName: String
    var tagColor: Date
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: 16)
            HStack{
                Text(leftoverName)
                    .font(.custom("Montserrat-Regular", size: 16, relativeTo: .body))
                
                Spacer()
                
                NavigationLink(destination: ShuffleView(selectedItemName:leftoverName)) {
                    Circle()
                        .foregroundColor(Color(hex: "816D54"))
                        .frame(width: 42, height: 42)
                        .overlay(
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white)
                                .font(.system(size: 12))
                        )
                }
            }
            Spacer().frame(height: 16)
            // add line here
            LineShape()
                .stroke(Color(hex: "EEE6DA"), lineWidth: 1)
        }
    }
}


struct LineShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}



// MARK: Backup Reinvent Card
struct reinventLOCard2: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var leftoverName: String
    var tagColor: Date
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text(leftoverName)
                
                Spacer()
                
                NavigationLink(destination: ShuffleView(selectedItemName:leftoverName)) {
                    Circle()
                        .foregroundColor(Color(hex: dateControlColor1(dependency: tagColor)))
                        .frame(width: 38, height: 38)
                        .shadow(color: Color(hex: dateControlColor3(dependency: tagColor)).opacity(0.15), radius: 5, x: 0, y: 4)
                        .overlay(
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white)
                                .font(.system(size: 14))
                        )
                }
                
                
            }
        }
        .padding().padding(.leading, 10).background(Color.white)
        .overlay(
            HStack{
                Rectangle() // Tag
                    .fill(Color(hex: dateControlColor2(dependency: tagColor)))
                    .frame(width: 10)
                    .alignmentGuide(.leading) { d in d[.leading] }
                Spacer()
            }
        )
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: 4)
        
        Spacer().frame(height: 20)
    }
}







struct EmptyPantryView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            Text("You don’t have any meals to reinvent yet...")
                .font(.custom("Montserrat-Regular", size: 16, relativeTo: .title3))
                .multilineTextAlignment(.leading)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}


// MARK: Virtual Pantry Background on ZStack level (Scrollable)
struct ReinventBackground: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var isShowingAddSheet = false // Trigger PantryFormView sheet
    
    var body: some View {
        GeometryReader { geo in
            ZStack{
                VStack{
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color(hex: "319070"))
                        .frame(width: geo.size.width, height: 732)
                        .offset(y: -480)
                }
                
                
                HStack{
                    Spacer()
                    Image("NYellowKawung")
                        .resizable()
                        .frame(width: geo.size.width/3.2, height: geo.size.width/3.2)
                        .offset(x: (geo.size.width/3.2)/2,y: -280)
                }
            }
        
        }
    }
}






//struct ReinventView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReinventView()
//    }
//}
