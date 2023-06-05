//
//  EditLOView.swift
//  MakanLagi
//
//  Created by Hilary Young on 02/05/2023.
//

// STATUS: WIP

import SwiftUI

struct EditLOView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.presentationMode) var presentationMode
    
    let itemName: String
    let dateString: String
    
    @State private var expDate = Date()
    
    let placeholderImage =  "https://firebasestorage.googleapis.com/v0/b/makanlagi-f9b8c.appspot.com/o/juice.png?alt=media&token=252c3688-441e-4db4-963e-f0f6af323da2"
    
    var body: some View {
        ZStack{
            Color(hex: "FFF9F0").edgesIgnoringSafeArea(.all) // background color
            
            ScrollView{
                VStack(alignment: .leading){
                    
                    // MARK: Drag down indicator
                    HStack {
                        Spacer()
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex:"E5DCCE"))
                            .frame(width: 70, height: 4)
                        Spacer()
                    }
                    
                    
                    // MARK: Header
                    Group{
                        Spacer().frame(height: 40)
                        Text("What's new?")
                            .font(.custom("PlayfairDisplay-Bold", size: 28, relativeTo: .title))
                            .foregroundColor(Color(hex: "3A290E"))
                            .fontWeight(.bold)
                        Spacer().frame(height: 8)
                        Text("Update the details of your leftover meal...")
                            .font(.custom("Montserrat-Regular", size: 18, relativeTo: .title3))
                        Spacer().frame(height: 40)
                    }
                    
                    // MARK: Original Leftover Data
                    OriginalLOCard(LOName: itemName, LODate: dateString)
                    
                    Spacer().frame(height:32)
                    
                    
                    
                    // MARK: Edit calendar
                    VStack(alignment:.leading) {
                        HStack {
                            // content of date picker
                            DatePicker(selection: $expDate, displayedComponents: .date) {
                                Text("Eat before:")
                                    .font(.custom("Montserrat-SemiBold", size: 16, relativeTo: .body))
                                    //.bold()
                            }
                            .accentColor(Color(hex: "F15533"))
                        }
                    }
                    .padding(.horizontal,16)
                    .padding(.vertical,16)
                    .frame(height: 56) // Set the same height as the text field
                    .background(Color(hex: "EEE6DA"))
                    .cornerRadius(100)
                    .shadow(color: Color.black.opacity(0.02), radius: 4, x: 0, y: 4)
                    
       
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                
            }
            VStack{
                Spacer()
                HStack{
                    // MARK: Delete leftover meal
                    Button(action: {
                        viewModel.deleteItem(itemName:itemName)
                        presentationMode.wrappedValue.dismiss()
                        viewModel.fetchItems()
                    }) {
                        BinButton()
                    }
                    
                    // MARK: Update leftover meal
                    Button(action: {
                        viewModel.addItem(newItemName: itemName, newExpDate: expDate)
                        presentationMode.wrappedValue.dismiss()
                        viewModel.fetchItems()
                    }) {
                        DefaultActiveButton(label: "Update Leftover", backHex: "F15533", textHex: "fff")
                    }
                }
            }
            .padding()
            
            .onAppear {
                viewModel.fetchItems() // always trigger the leftovername
            }
        }
    }
}




struct OriginalLOCard: View {

    var LOName: String
    var LODate: String
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .leading) {
                GeometryReader { geometry in
//                    Image("MakanLagiLine")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: geometry.size.width)
//                        .offset(y: -65)
                }
                .clipped()
                
                HStack {
                    // Content
                    VStack(alignment: .leading) {
                        Spacer()
                        
                        Text(LOName)
                            .font(.custom("Montserrat-Bold", size: 20, relativeTo: .title3))
                            //.font(.custom("Montserrat-SemiBold", size: 16, relativeTo: .body))
                            .foregroundColor(.white)
                        
                        Spacer().frame(height: 16)
                        
                        Text("Original expiration date:")
                            .font(.custom("Montserrat-Regular", size: 16, relativeTo: .body))
                            .foregroundColor(.white)
                        
                        Spacer().frame(height: 8)
                        
                        Text(LODate)
                            .font(.custom("Montserrat-Regular", size: 16, relativeTo: .body))
                            .foregroundColor(Color(hex: "5E4F37"))
                            .padding(.horizontal,16)
                            .padding(.vertical,8)
                            .background(Color(hex: "EEE6DA"))
                            .cornerRadius(100)
  
                    }
                    .padding(.trailing,8)
                    .padding(.bottom,4)
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Image("StackedBowlFlower")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 110)
                    }
                    .padding(.trailing,8)
                    // End of content
                }
                .padding()
            }
        }
        .background(Color(hex: "319070"))
        .cornerRadius(16)
    }
}
