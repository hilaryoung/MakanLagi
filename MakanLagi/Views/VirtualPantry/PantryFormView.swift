//
//  PantryFormView.swift
//  MakanLagi
//
//  Created by Hilary Young on 02/05/2023.
//

// Status: DONE

import SwiftUI

struct PantryFormView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.presentationMode) var presentationMode
    
    // Text fields
    @State private var newItem = ""
    @State private var expDate = Date()
    
    var body: some View {
        ZStack{
            Color(hex: "FFF9F0").edgesIgnoringSafeArea(.all) // background color
            
            ScrollView {
                
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
                        Text("Add to pantry")
                            .font(.custom("PlayfairDisplay-Bold", size: 28, relativeTo: .title))
                            .foregroundColor(Color(hex: "3A290E"))
                            .fontWeight(.bold)
                        Spacer().frame(height: 8)
                        Text("Input the details of your leftover meal...")
                            .font(.custom("Montserrat-Regular", size: 18, relativeTo: .title3))
                        Spacer().frame(height: 40)
                    }


                    VStack(spacing: 32) {
                        // MARK: Leftholder text field
                        VStack(alignment:.leading) {
                            HStack {
                                Text("Your meal:")
                                    .font(.custom("Montserrat-SemiBold", size: 16, relativeTo: .body))
                                    //.bold()
                                    .foregroundColor(Color(hex: "3A290E"))
                                Spacer()
                                TextField("Nasi goreng...", text: $newItem)
                                    .font(.custom("Montserrat-Regular", size: 16, relativeTo: .body))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.trailing)
                                    .accentColor(Color(hex: "F15533"))
                            }
                        }
                        .padding(.horizontal,16)
                        .padding(.vertical,16)
                        .frame(height: 56) // Set the desired height
                        .background(Color(hex: "EEE6DA"))
                        .cornerRadius(100)
                        .shadow(color: Color.black.opacity(0.02), radius: 4, x: 0, y: 4)
                        
                        // MARK: Expiration date picker
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

                    
                    
                    
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            VStack {
                Spacer()
                HStack{
                    // Add mascot image
                    
                    // Add Button
                    if newItem.isEmpty {
                        DefaultDisableButton(label: "Add to Pantry", backHex: "FAC3B8", textHex: "fff")
                    } else {
                        Button(action: {
                            viewModel.addItem(newItemName: newItem, newExpDate: expDate)
                            presentationMode.wrappedValue.dismiss()
                            viewModel.fetchItems()
                        }) {
                            DefaultActiveButton(label: "Add to Pantry", backHex: "F15533", textHex: "fff")
                        }
                    }
                    
                    
                }
            }
            .padding()
        }
        .navigationViewStyle(.stack)
        
        // Fetch user data
        .onAppear {
            viewModel.fetchItems()
        }
    }
}

//struct PantryFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        PantryFormView()
//    }
//}
