//
//  AwardDetailsView.swift
//  MakanLagi
//
//  Created by Hilary Young on 08/05/2023.
//

import SwiftUI

struct AwardDetailsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    // Variables
    let awardImg: String
    let awardDetailImg: String
    let photoImg: String
    let windowText: String
    let awardTitle: String
    let awardSubtitle: String
    let awardBody: String
    
    @State private var showFirstView = true
    
    let screenWidth = UIScreen.main.bounds.size.width
    
    var body: some View {
        ZStack{
            Color(hex: "FFF9F0").edgesIgnoringSafeArea(.all) // background color
            ScrollView {
                ZStack{
                    //KitBackground()
                    VStack(alignment: .leading){
                        
                        
                        // MARK: Drag down indicator
                        HStack {
                            Spacer()
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(hex:"E5DCCE"))
                                .frame(width: 70, height: 4)
                            Spacer()
                        }
                        
                        Spacer().frame(height: 24)
                        
                        
                        // MARK: AWARDS IMAGE
                        ZStack{
                            HStack{
                                Spacer()
                                VStack{
                                    if showFirstView {
                                        ViewOne(awardDetailImg:awardDetailImg)
                                    } else {
                                        ViewTwo(photoImg:photoImg )
                                    }
                                }
                                Spacer()
                            }
                            
                            VStack(alignment: .trailing){
                                Spacer()
                                Button(action: {
                                    withAnimation {
                                        showFirstView.toggle()
                                    }
                                }) {
                                    FlipButton()
                                        .padding(.bottom,16)
                                        .padding(.trailing,32)
                                }
                            }
                        }
                        
                        Spacer().frame(height: 32)
                        
                        // MARK: Header
                        Group{
                            VStack{
                                Text(awardSubtitle)
                                    .font(.custom("Montserrat-Regular", size: 14, relativeTo: .body))
                                    .foregroundColor(Color(hex: "5E4F37"))
                            }
                            .padding(.horizontal,16)
                            .padding(.vertical,12)
                            .background(Color(hex: "EEE6DA"))
                            .cornerRadius(1000)
                            
                            Spacer().frame(height: 16)
                            
                            Text(awardTitle)
                                .font(.custom("PlayfairDisplay-Bold", size: 28, relativeTo: .title))
                                .foregroundColor(Color(hex: "3A290E"))
                                .fontWeight(.bold)
                            
                            Spacer().frame(height: 24)
                            
                            Text(awardBody)
                                .font(.custom("Montserrat-Regular", size: 16, relativeTo: .body))
                                .lineSpacing(8)
                        }
                        .padding(.horizontal, 8)
                        
                        
                        Spacer().frame(height: 24)
                        
                        
                        Group{
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                DefaultActiveButton(label: "Done", backHex: "F15533", textHex: "fff")
                            }
                        }
                        .padding(.horizontal, 8)
                        
                        
                        
                        
                        
                        
                        
                        // MARK: AWARDS DETAIL
//                        VStack(alignment: .leading){
//                            Text(awardTitle)
//                                .font(.title).bold()
//                                .padding(.bottom,16)
//                                .foregroundColor(Color(hex: "F15533"))
//                            Text(awardSubtitle)
//                                .font(.title3).bold()
//                                .padding(.bottom,4)
//                            Text(awardBody)
//                                .font(.body)
//                        }
//                        .padding(8)

                        
                

    
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
        // MARK: RETRIEVING DATA
        .onAppear {
            //viewModel.fetchAwards()
        }
    }
}



struct ViewOne: View {
    
    let screenWidth = UIScreen.main.bounds.size.width
    
    let awardDetailImg: String
    
    var body: some View {
    
        
        VStack(alignment: .center){
            
            AsyncImage(url: URL(string: awardDetailImg)) { image in
                image.resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 24))
            } placeholder: {
                ProgressView() // loader
            }
            .aspectRatio(1, contentMode: .fit)
            
        }
        .frame(width: screenWidth*0.85, height: screenWidth*0.85)
        .background(Color(hex: "FFF9F0"))
        .cornerRadius(24)
        .shadow(color: Color(hex: "BEB3A2").opacity(0.5), radius: 4, x: -4, y: 4)
    }
}


struct ViewTwo: View {
    
    let screenWidth = UIScreen.main.bounds.size.width
    let photoImg: String
    
    var body: some View {
        VStack(alignment: .center){
            
            AsyncImage(url: URL(string: photoImg)) { image in
                image.resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 24))
            } placeholder: {
                ProgressView() // loader
            }
            .aspectRatio(1, contentMode: .fit)
            
        }
        .frame(width: screenWidth*0.85, height: screenWidth*0.85)
        .background(.white)
        .cornerRadius(24)
        .shadow(color: Color(hex: "BEB3A2").opacity(0.5), radius: 6, x: -6, y: 6)
    }
}



struct FlipButton: View {
    var body: some View {
        HStack{
            Spacer()
            
            Circle()
                .foregroundColor(Color(hex: "3A290E"))
                .frame(width: 56, height: 56)
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: -4, y: 4)
                .overlay(
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                )
        }
    }
}







//struct AwardDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AwardDetailsView()
//    }
//}
