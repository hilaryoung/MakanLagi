//
//  AwardInformationView.swift
//  MakanLagi
//
//  Created by Hilary Young on 20/05/2023.
//

import SwiftUI

struct AwardInformationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
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
                        Text("Collecting awards")
                            .font(.custom("PlayfairDisplay-Bold", size: 28, relativeTo: .title))
                            .foregroundColor(Color(hex: "3A290E"))
                            .fontWeight(.bold)
                        Spacer().frame(height: 8)
                        Text("How you can start collecting....")
                            .font(.custom("Montserrat-Regular", size: 18, relativeTo: .title3))
                        Spacer().frame(height: 48)
                    }
                    
                    
                    // MARK: Description
                    Group{
                        Text(
                            "The awards system tracks all the times you successfully saving your leftovers from becoming food waste. You will get an award stamp every time you…"
                        )
                        .font(.custom("Montserrat-Regular", size: 16, relativeTo: .body))
                        .lineSpacing(8)
                        
                        Spacer().frame(height:40)
                    }
                    
                    // MARK: INSTRUCTIONS CAROUSELL
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            Spacer().frame(width: 0.0001)
                            
                            // Reinventing Tool Section
                            VStack(alignment: .leading) {
                                Image("NYellowKawung")
                                    .resizable()
                                    .frame(width: 42, height: 42)
                                    .shadow(
                                        color: Color(hex: "C6B8A4").opacity(0.4),
                                        radius: 4, x: -4, y: 4
                                    )
                                
                                Spacer().frame(height: 16)
                                
                                Text("Reinventing Tool")
                                    .font(.custom("Montserrat-Regular", size: 20))
                                    .bold()
                                
                                Spacer().frame(height: 16)
                                
                                Text("Reinvent your leftover meal with native spices and complete the recipe.")
                                    .font(.custom("Montserrat-Regular", size: 16, relativeTo: .body))
                                    .lineSpacing(8)
                                
                                Spacer().frame(height:8)
                            }
                            .padding()
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(width: UIScreen.main.bounds.width / 1.75)
                            .frame(maxHeight: .infinity, alignment: .topLeading) // Set maximum height
                            .background(Color(hex: "EEE6DA"))
                            .cornerRadius(16)
                            .shadow(
                                color: Color(hex: "DDDDDD").opacity(0.5),
                                radius: 4, x: -4, y: 4
                            )

                            
                            // Virtual Pantry Section
                            VStack(alignment: .leading) {
                                Image("NPinkKawung")
                                    .resizable()
                                    .frame(width: 42, height: 42)
                                    .shadow(
                                        color: Color(hex: "C6B8A4").opacity(0.4),
                                        radius: 4, x: -4, y: 4
                                    )
                                
                                Spacer().frame(height: 16)
                                
                                Text("Virtual Pantry")
                                    .font(.custom("Montserrat-Regular", size: 20))
                                    .bold()
                                
                                Spacer().frame(height: 16)
                                
                                Text("Finish your leftover before its set expiration date.")
                                    .font(.custom("Montserrat-Regular", size: 16, relativeTo: .body))
                                    .lineSpacing(8)
                                
                                Spacer()
                                Spacer().frame(height:8)
                            }
                            .padding()
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(width: UIScreen.main.bounds.width / 1.75)
                            .frame(maxHeight: .infinity, alignment: .topLeading) // Set maximum height
                            .background(Color(hex: "EEE6DA"))
                            .cornerRadius(16)
                            .shadow(
                                color: Color(hex: "DDDDDD").opacity(0.5),
                                radius: 4, x: -4, y: 4
                            )
                            
                            Spacer().frame(width: 0.0001)// ensures padding on first view
                        }
                        .padding(.bottom,16)
                    }
                    .padding(.horizontal, -16) // remove original padding
                    
                    
                    
                    
                    

                    
       
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                
            }
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Group{
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            DefaultActiveButton(label: "Done", backHex: "F15533", textHex: "fff")
                        }
                    }
                    .padding(.horizontal, 8)
                    Spacer()
                }
            }
            .padding()
            
            .onAppear {
                // on appear
            }
        }
    }
}

//struct AwardInformationView_Previews: PreviewProvider {
//    static var previews: some View {
//        AwardInformationView()
//    }
//}
