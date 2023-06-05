//
//  ExpiredPopUp.swift
//  MakanLagi
//
//  Created by Hilary Young on 09/05/2023.
//

import SwiftUI

struct ExpiredPopUp: View {
    
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
            
            
            // MARK: Content
//            VStack{
//                AsyncImage(url: URL(string: awards[awardValue].awardImg)) { image in
//                    image
//                        .resizable()
//                        .scaledToFill()
//                } placeholder: {
//                    ProgressView()
//                }
//            }
//            .frame(width: 160, height: 160)
//            .cornerRadius(16)
//            .clipped()
//            .shadow(
//                color: Color(hex: "BEB3A2").opacity(0.4),
//                radius: 4, x: -4, y: 4
//            )
            
            VStack{
                Image("NyonyaV2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 160, height: 160)
                    .cornerRadius(16)
            }
            .clipped()
            .shadow(
                color: Color(hex: "BEB3A2").opacity(0.4),
                radius: 4, x: -4, y: 4
            )
            
            
            Spacer().frame(height: 20)
            
            // 3. Award windowText
            HStack{
                Spacer().frame(width: 16)
                Text("This meal has past its expiration date. We’re you able to save it?")
                    .multilineTextAlignment(.center)
                    .font(.custom("Montserrat-Regular", size: 16, relativeTo: .body))
                    .lineSpacing(8)
                
                Spacer().frame(width: 28)
            }
            
            
            // MARK: Claim award
            
            HStack{
                // MARK: No
                Button(action: {
                    withAnimation {
                        showAwardPopUp.toggle() // Action 1: Close popup
                        viewModel.deleteItem(itemName: itemName)
                        print("Award not claimed")
                    }
                }) {
                    DefaultActiveButton(label: "No", backHex: "EEE6DA", textHex: "947E61")
                }
                
                
                // MARK: Yes
                Button(action: {
                    withAnimation {
                        showAwardPopUp.toggle() // Action 1: Close popup
                        viewModel.deleteItem(itemName: itemName)
                        // Printing info
                        print("Leftover completed without award")
                    }
                }) {
                    DefaultActiveButton(label: "Yes", backHex: "F15533", textHex: "fff")
                }
                
            }
            
            
            Spacer().frame(height: 4)
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        
        .onAppear {
            apiAwardsCall().getAwards { (awards) in
                self.awards = awards
            }
        }
    }
}

//struct ExpiredPopUp_Previews: PreviewProvider {
//    static var previews: some View {
//        ExpiredPopUp()
//    }
//}
