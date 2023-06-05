//
//  WarningPopUp.swift
//  MakanLagi
//
//  Created by Hilary Young on 09/05/2023.
//

import SwiftUI

struct WarningPopUp: View {
    
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
                    CloseButton(buttonSize: 34, icSize: 14, backHex: "000", lineHex: "000", icHex: "fff")
                }
            }
            
            
            // MARK: Content
            Text("Warning!")
                .font(.title2).bold()
            
            Text("Did you save your leftover?")
            
            
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
                    DefaultActiveButton(label: "No", backHex: "F9D2CA", textHex: "F15533")
                }
                
                
                // MARK: Yes
                Button(action: {
                    withAnimation {
                        showAwardPopUp.toggle() // Action 1: Close popup
                        viewModel.deleteItem(itemName: itemName)
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

//struct WarningPopUp_Previews: PreviewProvider {
//    static var previews: some View {
//        WarningPopUp()
//    }
//}
