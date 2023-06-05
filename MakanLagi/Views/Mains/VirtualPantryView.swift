//
//  VirtualPantryView.swift
//  MakanLagi
//
//  Created by Hilary Young on 02/05/2023.
//

// STATUS: WIP
// Modal Popup Display

import SwiftUI



struct VirtualPantryView: View {
    // Link to model
    @EnvironmentObject var viewModel: AppViewModel
    
    // Data variables
    @State private var itemName: String = "" // Leftover name
    @State private var dateString: String = "" // Date as string
    @State private var awardValue: Int?
    
    // Sheet states
    @State private var isShowingAddSheet = false
    @State private var isShowingEditSheet = false
    @State private var isShowingFFSheet = false
    
    @State private var showAwardPopUp: Bool = false
    @State private var showWarningPopUp: Bool = false
    @State private var showExpiredPopUp: Bool = false
    
    @State private var searchText: String = ""
    
    // trial
    @State private var verticalSpacer: CGFloat = 200
    @State private var awardSpacer: CGFloat = UIScreen.main.bounds.width/2.75
    @State private var warningSpacer: CGFloat = UIScreen.main.bounds.width/2.75
    //@State private var warningSpacer: CGFloat = 160
    @State private var expiredSpacer: CGFloat = UIScreen.main.bounds.width/2.80
    
    
    
    var body: some View {
        ZStack{
            Color(hex: "FFF9F0").edgesIgnoringSafeArea(.all) // background color
            ScrollView {
                ZStack{
                    VPBackground()
                    
                    VStack(alignment: .leading){
                        
                        // MARK: Header
                        Group{
                            Spacer().frame(height: 56)
                            Text("Virtual Pantry")
                                .font(.custom("PlayfairDisplay-Bold", size: 28, relativeTo: .title))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                            Spacer().frame(height: 8)
                            Text("All the meals you can save...")
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
                        
                        
                        
                        // MARK: Spacers
                        Group{
                            Spacer().frame(height: 16) // edge of banner
                            Spacer().frame(height: 24) // Spacing from edge of banner to top
                        }
                        
                        
                        
                        if viewModel.items.isEmpty {
                            Text("You don’t have any meals to save yet...")
                                .font(.custom("Montserrat-Regular", size: 16, relativeTo: .title3))
                                .multilineTextAlignment(.leading)
                        }
                        else {
                            
                            ForEach(viewModel.items.filter { searchText.isEmpty || $0.itemName.localizedCaseInsensitiveContains(searchText) }
                                .sorted { abs($0.expDate.timeIntervalSinceNow) < abs($1.expDate.timeIntervalSinceNow) },
                                    id: \.id) { item in
                                // MARK: Leftover Card
                                VStack(alignment: .leading) {
                                    Spacer().frame(height: 16)
                                    // start of content
                                    HStack{
                                        // 1. Leftover name
                                        Text(item.itemName)
                                            .font(.custom("Montserrat-Regular", size: 16, relativeTo: .body))
                                        
                                        Spacer()
                                        
                                        // 2. Edit expiration button
                                        Group{
                                            Button(action: {
                                                itemName = item.itemName
                                                dateString = dateToWords(item.expDate)
                                                print("Editing \(item.itemName), Exp date: \(dateString)")
                                                isShowingEditSheet = true
                                            }) {
                                                EditExpDays(expDate: item.expDate)
                                            }
                                        }
                                        
                                        // 3. Complete button
                                        Group{
                                            Button(action: {
                                                itemName = item.itemName
                                                if item.expDate.timeIntervalSinceNow <= 0 { // expired
                                                    showExpiredPopUp.toggle()
                                                } else if item.expDate.timeIntervalSinceNow <= 86400 { // 0-24 hours
                                                    showWarningPopUp.toggle()
                                                } else { // above 1 day
                                                    showAwardPopUp.toggle()
                                                }
                                            }) {
                                                CompleteLOButton(
                                                    expDate: item.expDate,
                                                    colHex: dateControlColor1(dependency: item.expDate),
                                                    shadowHex: dateControlColor3(dependency: item.expDate)
                                                )
                                            }
                                        }
                                        
                                        
                                    }
                                    // end of content
                                    Spacer().frame(height: 16)
                                    LineShape()
                                        .stroke(Color(hex: "EEE6DA"), lineWidth: 1)
                                }
                                //}
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
                    .padding().frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
            }
            
            // MARK: Sticky components (BOTTOM)
            VStack {
                
                Spacer()
                HStack{
                    Spacer()
                    VStack{
                        Spacer()
                        if viewModel.items.isEmpty{
                            HStack{
                                Text("psttt... add your leftover meal here")
                                    .font(.custom("PlayfairDisplay-BoldItalic", size: 18, relativeTo: .title3))
                                    .foregroundColor(Color(hex: "F15533"))
                                Image(systemName: "arrow.right")
                                    .font(.body)
                                    .foregroundColor(Color(hex: "F15533"))
                            }
                            .frame(width: UIScreen.main.bounds.width / 2)
                        }
                    }
                    
                    VStack{
                        Spacer()
                        Button(action: {
                            isShowingAddSheet = true
                            
                        }) {
                            Circle()
                                .foregroundColor(Color(hex: "3A290E"))
                                .frame(width: 56, height: 56)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
                                .overlay(
                                    Image(systemName: "plus")
                                        .foregroundColor(.white)
                                )
                        }
                        
                    }
                    
                }
            }
            .padding().padding(.bottom,68)
        }
        .accentColor(Color(hex: "F15533"))
        
        // MARK: Pages and data configurations
        .sheet(isPresented: $isShowingAddSheet) {
            PantryFormView()
        }
        
        .sheet(isPresented: $isShowingFFSheet) {
            FeaturesFunctionsView()
        }
        
        .sheet(isPresented: $isShowingEditSheet) {
            EditLOView(itemName: itemName, dateString:dateString)
        }
        
        .popupNavigationView(show: $showAwardPopUp, verticalSpacer: $awardSpacer) {
            AwardPopUpVP(showAwardPopUp: $showAwardPopUp, itemName:itemName, awardValue: Int.random(in: 0...11))
        }
        
        .popupNavigationView(show: $showWarningPopUp, verticalSpacer: $warningSpacer) {
            AwardPopUpVP(showAwardPopUp: $showWarningPopUp, itemName:itemName, awardValue: Int.random(in: 0...11))
        }
        
        .popupNavigationView(show: $showExpiredPopUp, verticalSpacer: $expiredSpacer) {
            ExpiredPopUp(showAwardPopUp: $showExpiredPopUp, itemName:itemName, awardValue: Int.random(in: 0...11))
        }
        
        .onAppear {
            viewModel.fetchItems()
        }
        
    }
}




// MARK: Virtual Pantry Background on ZStack level (Scrollable)
struct VPBackground: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var isShowingAddSheet = false // Trigger PantryFormView sheet
    
    var body: some View {
        GeometryReader { geo in
            ZStack{
                VStack{
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color(hex: "F56C30"))
                        .frame(width: geo.size.width, height: 732)
                        .offset(y: -480)
                }
                
                ZStack{
                    HStack{
                        Spacer()
                        Image("NPinkKawung")
                            .resizable()
                            .frame(width: geo.size.width/4.8, height: geo.size.width/4.8)
                        //.frame(width: 150, height: 150)
                            .offset(x: (geo.size.width/4.8)/2,y: -260)
                    }
                    
                    HStack{
                        Spacer()
                        Image("NPinkKawung")
                            .resizable()
                            .frame(width: geo.size.width/4.8, height: geo.size.width/4.8)
                        //.frame(width: 150, height: 150)
                            .offset(
                                x: ((geo.size.width/4.8)/2)-(geo.size.width/(4.8+0.75)),
                                y: -260-((geo.size.width/4.8)/2)
                            )
                    }
                }
            }
            
        }
    }
}


struct ViewCalendarButton: View {
    var body: some View {
        HStack {
            Text("Add leftover")
                .font(.custom("Montserrat-Regular", size: 16, relativeTo: .body))
            //.bold()
            Image(systemName: "plus")
        }
        .padding(.horizontal,24)
        .padding(.vertical, 16)
        .foregroundColor(.white)
        .background(Color(hex: "3A290E"))
        .cornerRadius(100)
    }
}







//struct VirtualPantryView_Previews: PreviewProvider {
//    static var previews: some View {
//        VirtualPantryView()
//    }
//}



