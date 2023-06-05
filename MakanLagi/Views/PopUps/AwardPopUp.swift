//
//  AwardPopUp.swift
//  MakanLagi
//
//  Created by Hilary Young on 03/05/2023.
//

// BUG TO FIX
// Reading from json file

import SwiftUI

struct AwardPopUp: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    @State var awards: [Award] = []
    
    @Binding var showAwardPopUp: Bool
    
    let itemName: String
    let awardValue: Int

    
    var body: some View {
        VStack{
            // MARK: Close Windows
            HStack{
                Spacer()
                Button(action: {
                    withAnimation {
                        showAwardPopUp.toggle() // Action 1: Close popup
                    }}) {
                    CloseButton(
                        buttonSize: 42,
                        icSize: 42,
                        backHex: "3A290E",
                        lineHex: "3A290E",
                        icHex: "fff"
                    )
                    .shadow(
                        color: Color(hex: "C6B8A4").opacity(0.4),
                        radius: 4, x: -4, y: 4
                    )
                }
            }
            
            // MARK: Header
            VStack{
                Group{
                    if awards.count >= 11 { // MARK: Local award

                        VStack{
                            AsyncImage(url: URL(string: awards[awardValue].awardImg)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        .frame(width: 160, height: 160)
                        .cornerRadius(16)
                        .clipped()
                        .shadow(
                            color: Color(hex: "BEB3A2").opacity(0.4),
                            radius: 4, x: -4, y: 4
                        )
                        
                        Spacer().frame(height: 20)
                        
                        // 3. Award windowText
                        HStack{
                            Spacer().frame(width: 16)
                            Text(awards[awardValue].windowText)
                                .multilineTextAlignment(.center)
                                .font(.custom("Montserrat-Regular", size: 16, relativeTo: .body))
                                .lineSpacing(8)
                            
                            Spacer().frame(width: 28)
                        }
                    
                    } else { // MARK: Safe guard award
                        Text("No award found")
                    }
                }
            }
            
            
            // MARK: Check passed data
            //Group{
                //Spacer().frame(height: 8)
                //Text("Passed meal: \(itemName)")
                //Text("Award value generated: \(awardValue)")
            //}

            
            // MARK: Claim award
            Button(action: {
                withAnimation {
                    showAwardPopUp.toggle() // Action 1: Close popup
                    //viewModel.deleteItem(itemName: itemName) // Action 2: remove data from database
                    // Add award details to firebase
                    viewModel.addAward(
                        awardImg: awards[awardValue].awardImg,
                        awardDetailImg: awards[awardValue].awardDetailImg,
                        photoImg: awards[awardValue].photoImg,
                        windowText: awards[awardValue].windowText,
                        title: awards[awardValue].title,
                        subtitle: awards[awardValue].subtitle,
                        body: awards[awardValue].body
                    )
                    // Printing info
                    print("Award value: \(awardValue) claimed")
                }
            }) {
                
                DefaultActiveButton(label: "Claim Award!", backHex: "F15533", textHex: "fff")
                    .padding(.horizontal, 32)
            }
            
            Spacer().frame(height: 4)
            
        }
        .navigationBarHidden(true)
        //.navigationBarHidden(true)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        
        .onAppear {
            apiAwardsCall().getAwards { (awards) in
                self.awards = awards
            }
        }
    }
}




// MARK: Award popup for virtual pantry
// extra action to delete the item selected

struct AwardPopUpVP: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    @State var awards: [Award] = []
    
    @Binding var showAwardPopUp: Bool
    
    let itemName: String
    let awardValue: Int

    
    var body: some View {
        VStack{
            // MARK: Close Windows
            HStack{
                Spacer()
                Button(action: {
                    withAnimation {
                        showAwardPopUp.toggle() // Action 1: Close popup
                    }}) {
                        CloseButton(
                            buttonSize: 42,
                            icSize: 42,
                            backHex: "3A290E",
                            lineHex: "3A290E",
                            icHex: "fff"
                        )
                        .shadow(
                            color: Color(hex: "C6B8A4").opacity(0.4),
                            radius: 4, x: -4, y: 4
                        )
                }
            }
            
            // MARK: Header
            VStack{
                Group{
                    if awards.count >= 11 { // MARK: Local award
                        
                        VStack{
                            AsyncImage(url: URL(string: awards[awardValue].awardImg)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        .frame(width: 160, height: 160)
                        .cornerRadius(16)
                        .clipped()
                        .shadow(
                            color: Color(hex: "BEB3A2").opacity(0.4),
                            radius: 4, x: -4, y: 4
                        )
                        
                        Spacer().frame(height: 20)
                        
                        // 3. Award windowText
                        HStack{
                            Spacer().frame(width: 16)
                            Text(awards[awardValue].windowText)
                                .multilineTextAlignment(.center)
                                .font(.custom("Montserrat-Regular", size: 16, relativeTo: .body))
                                .lineSpacing(8)
                            
                            Spacer().frame(width: 28)
                        }
                        
                    
                    } else { // MARK: Safe guard award
                        Text("No award found")
                    }
                }
            }
            
            
            // MARK: Check passed data
            //Group{
                //Spacer().frame(height: 8)
                //Text("Passed meal: \(itemName)")
                //Text("Award value generated: \(awardValue)")
            //}

            
            // MARK: Claim award
            Button(action: {
                withAnimation {
                    showAwardPopUp.toggle() // Action 1: Close popup
                    viewModel.deleteItem(itemName: itemName) // Action 2: remove data from database
                    // Add award details to firebase
                    viewModel.addAward(
                        awardImg: awards[awardValue].awardImg,
                        awardDetailImg: awards[awardValue].awardDetailImg,
                        photoImg: awards[awardValue].photoImg,
                        windowText: awards[awardValue].windowText,
                        title: awards[awardValue].title,
                        subtitle: awards[awardValue].subtitle,
                        body: awards[awardValue].body
                    )
                    // Printing info
                    print("Award value: \(awardValue) claimed")
                }
            }) {
                DefaultActiveButton(label: "Claim Award!", backHex: "F15533", textHex: "fff")
                    .padding(.horizontal, 32)
            }
            
            Spacer().frame(height: 4)
            
        }
        .navigationBarHidden(true)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        
        .onAppear {
            apiAwardsCall().getAwards { (awards) in
                self.awards = awards
            }
        }
    }
}


//struct AwardPopUp_Previews: PreviewProvider {
//    static var previews: some View {
//        AwardPopUp()
//    }
//}
