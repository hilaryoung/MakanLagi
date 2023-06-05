//
//  AddStarterKitView.swift
//  MakanLagi
//
//  Created by Hilary Young on 07/05/2023.
//

import SwiftUI

struct AddStarterKitView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.presentationMode) var presentationMode
    
    // Text fields
    @State private var kitCode = ""
    @State private var isInvalidCode = false
    
    
    var body: some View {
        ZStack{
            Color(hex: "FFF9F0").edgesIgnoringSafeArea(.all) // background color
            
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
                    Text("Time to reinvent")
                        .font(.custom("PlayfairDisplay-Bold", size: 28, relativeTo: .title))
                        .foregroundColor(Color(hex: "3A290E"))
                        .fontWeight(.bold)
                    Spacer().frame(height: 8)
                    Text("Add the code to your starter kit...")
                        .font(.custom("Montserrat-Regular", size: 18, relativeTo: .title3))
                    Spacer().frame(height: 40)
                }
                
                
                // MARK: Your code text field
                VStack(alignment:.leading) {
                    HStack {
                        Text("Your meal:")
                            .font(.custom("Montserrat-SemiBold", size: 16, relativeTo: .body))
                            //.bold()
                            .foregroundColor(Color(hex: "3A290E"))
                        Spacer()
                        TextField("KC001...", text: $kitCode)
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

                
                
                
                if isInvalidCode {
                    Text("Code invalid")
                        .foregroundColor(.red)
                        .padding(.top, 4)
                }

            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
            
            VStack{
                Spacer()
                Button(action: {
                    if kitCode == "KC001" || kitCode == "KC002" || kitCode == "KC003" {
                        viewModel.addKitCode(newKitCode: kitCode)
                        //viewModel.fetchKitCode()
                        viewModel.fetchFirstKitCode()
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        isInvalidCode = true
                    }
                }) {
                    DefaultActiveButton(label: "Confirm Code", backHex: "F15533", textHex: "fff")
                }
                .disabled(kitCode.isEmpty)
            }
            .padding()
            
        }
    }
}

