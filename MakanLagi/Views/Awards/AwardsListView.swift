//
//  AwardsListView.swift
//  MakanLagi
//
//  Created by Hilary Young on 08/05/2023.
//

import SwiftUI

struct AwardsListView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) private var dismiss
    
    @State private var isAwardInfoSheet = false // Trigger PantryFormView sheet
    @State private var isAwardDetailsSheet = false
    
    // holder
    @State private var awardImg: String = ""
    @State private var awardDetailImg: String = ""
    @State private var photoImg: String = ""
    @State private var windowText: String = ""
    @State private var awardTitle: String = ""
    @State private var awardSubtitle: String = ""
    @State private var awardBody: String = ""
    
    let awardsCols = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ZStack{
            Color(hex: "FFF9F0").edgesIgnoringSafeArea(.all) // background color
            ScrollView {
                ZStack{
                    //KitBackground()
                    VStack(alignment: .leading){
                        
                        // MARK: Header
                        Group{
                            Spacer().frame(height: 12)
                            Text("Your Awards")
                                .font(.custom("PlayfairDisplay-Bold", size: 28, relativeTo: .title))
                                .foregroundColor(Color(hex: "3A290E"))
                                .fontWeight(.bold)
                            Spacer().frame(height: 8)
                            Text("Small changes lead to big impact!")
                                .font(.custom("Montserrat-Regular", size: 18, relativeTo: .title3))
                            Spacer().frame(height: 16)
                        }
                        
                        Spacer().frame(height: 32)
                        
                        
                        // MARK: Awards list
                        if viewModel.awards.isEmpty {
                            Text("You don’t have any awards yet...")
                                .font(.custom("Montserrat-Regular", size: 16, relativeTo: .title3))
                                .multilineTextAlignment(.leading)
                            
                        } else{
                            
                            LazyVGrid(columns: awardsCols, spacing: 16) {
                                ForEach(viewModel.awards, id: \.id) { award in
                                    
                                    Button(action: {
                                        awardImg = award.awardImg
                                        awardDetailImg = award.awardDetailImg
                                        photoImg = award.photoImg
                                        windowText = award.windowText
                                        awardTitle = award.title
                                        awardSubtitle = award.subtitle
                                        awardBody = award.body
                                        
                                        isAwardDetailsSheet = true
                                        
                                    }) {
                                        AsyncImage(url: URL(string: award.awardImg)) { image in
                                            image.resizable()
                                                .cornerRadius(8)
                                        } placeholder: {
                                            ProgressView() // loader
                                        }
                                        .padding(6)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .aspectRatio(1, contentMode: .fit)
                                        .background(Color(hex: "EEE6DA"))
                                        .cornerRadius(12)
                                        .shadow(
                                            color: Color(hex: "DDDDDD").opacity(0.5),
                                            radius: 4, x: -4, y: 4
                                        )
                                    }
                                    
                                }
                            }
                            
                        }
                        
                        
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
            }
            // MARK: Sticky components (BOTTOM)
            VStack {
                Spacer()
                HStack{
                    Spacer()
                    VStack{
                        Spacer()
                        if viewModel.awards.isEmpty{
                            HStack{
                                Text("psttt... heres how you can start collecting them")
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
                            isAwardInfoSheet = true
                            
                        }) {
                            Circle()
                                .foregroundColor(Color(hex: "3A290E"))
                                .frame(width: 56, height: 56)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
                                .overlay(
                                    Image(systemName: "info")
                                        .foregroundColor(.white)
                                )
                        }
                        
                    }
                    
                }
            }
            .padding().padding(.bottom,68)
        }
        
        
        
        // MARK: RETRIEVING DATA
        .onAppear {
            viewModel.fetchAwards()
        }
        
        .sheet(isPresented: $isAwardInfoSheet) {
            AwardInformationView()
        }
        
        .sheet(isPresented: $isAwardDetailsSheet) {
            AwardDetailsView(
                awardImg: awardImg,
                awardDetailImg: awardDetailImg,
                photoImg: photoImg,
                windowText: windowText,
                awardTitle: awardTitle,
                awardSubtitle: awardSubtitle,
                awardBody: awardBody
            )
        }
    }
}


struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.backward")
                Text("Custom Back")
            }
        }
    }
}

//struct AwardsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        AwardsListView()
//    }
//}
