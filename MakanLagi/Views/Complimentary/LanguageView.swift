//
//  LanguageView.swift
//  MakanLagi
//
//  Created by Hilary Young on 31/05/2023.
//
import Combine
import SwiftUI
import LanguageManagerSwiftUI

struct LanguageView: View {
    
    @EnvironmentObject var languageSettings: LanguageSettings
    
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
                            Text("language-string")
                                .font(.custom("PlayfairDisplay-Bold", size: 28, relativeTo: .title))
                                .foregroundColor(Color(hex: "3A290E"))
                                .fontWeight(.bold)
                            Spacer().frame(height: 8)
                            Text("language-page-desc")
                                .font(.custom("Montserrat-Regular", size: 18, relativeTo: .title3))
                            Spacer().frame(height: 16)
                        }
                        
                        Spacer().frame(height: 32)
                        
                        //Text("hello-string")
                        
                        Button(action: {
                            withAnimation {
                              languageSettings.selectedLanguage = .id
                            }
                            
                        }, label: {
                            settingOptionCard(title: "Indonesian")
                        })
                        
                        Button(action: {
                            withAnimation {
                              languageSettings.selectedLanguage = .en
                            }
                            
                        }, label: {
                            settingOptionCard(title: "English")
                        })
                        
                        
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
            }
            // MARK: Sticky components (BOTTOM)
            VStack {
                Spacer()
                // bottom sticky
            }
            .padding().padding(.bottom,68)
        }
    }
}
