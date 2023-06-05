//
//  SettingView.swift
//  MakanLagi
//
//  Created by Hilary Young on 02/05/2023.
//

import SwiftUI
import MessageUI


struct SettingView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @State private var searchText: String = ""
    
    var body: some View {
        ZStack{
            Color(hex: "FFF9F0").edgesIgnoringSafeArea(.all) // background
            
            ScrollView{
                //SettingBackground()
                
                ZStack{
                    VStack(alignment: .leading){
                        
                        // HEADER
                        Group{
                            Spacer().frame(height: 56)
                            Text("Settings")
                            //Text("Pengaturan")
                                //.font(.largeTitle).bold()
                                .font(.custom("PlayfairDisplay-Bold", size: 32, relativeTo: .largeTitle))
                                .foregroundColor(Color(hex: "3A290E"))
                            Spacer().frame(height: 4)
                            Text("Manage your account")
                            //Text("Mengelola akun anda")
                                //.font(.title3)
                                .font(.custom("Montserrat-Regular", size: 18, relativeTo: .title3))
                            Spacer().frame(height: 42)
                        }
                        
                        
                        // MARK: Search Bar
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color(hex: "5B4D38"))
                            //eng
                            TextField("Search for configuration...", text: $searchText)
                            //TextField("Cari konfigurasi...", text: $searchText)
                                .foregroundColor(Color(hex: "5B4D38"))
                                .autocapitalization(.none)
                        }
                        .padding()
                        .background(Color(hex: "E5DCCE"))
                        .cornerRadius(100)
                        .onTapGesture {
                            // Dismiss keyboard when tapped outside the search bar
                            hideKeyboard()
                        }
                        //.shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: 4)
                        
                        
                        Spacer().frame(height: 32)
                        

                        Button(action: {
                            print("Get your reinventing kit")
                            UIApplication.shared.open(URL(string: "https://www.makanlagi.site")!)
                        }, label: {
                            settingOptionCard(title: "Get your reinventing kit")
                        })
                        
                        Button(action: {
                            print("Support contact")
                            if let url = URL(string: "mailto:contact.makanlagi@gmail.com") {
                                    UIApplication.shared.open(url)
                                }
                            // action to email
                        }, label: {
                            // enf
                            settingOptionCard(title: "Support contact")
                            //settingOptionCard(title: "Kontak bantuan")
                        })
                        
                        NavigationLink {
                            LanguageView()
                        } label: {
                            // eng
                            settingOptionCard(title: "Language")
                            //settingOptionCard(title: "Bahasa")
                        }
                        
                        
                        NavigationLink {
                            PrivacyPolicyView() 
                        } label: {
                            //eng
                            settingOptionCard(title: "Privacy policy")
                            //settingOptionCard(title: "Kebijakan pribadi")
                        }
                        
                        
                        Button(action: {
                            viewModel.signOut()
                        }, label: {
                            //eng
                            settingOptionCard(title: "Sign out")
                            //settingOptionCard(title: "Keluar akun")
                        })
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
            }
        }
    }
}



// MARK: Home Background on ZStack level (Scrollable)
struct SettingBackground: View {
    
    var body: some View {
        GeometryReader { geo in
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color(hex: "E5DCCE"))
                .frame(width: geo.size.width, height: 700)
                .offset(y: -480)
        }
    }
}




struct labelActionCard: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text(title)
                    .foregroundColor(.black)
                
                Spacer()
                
                Circle()
                    .foregroundColor(Color(hex: "947E61"))
                    .frame(width: 38, height: 38)
                    .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: 4)
                    .overlay(
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                    )
 
            }
        }
        .frame(maxWidth: .infinity)
        .padding().padding(.leading, 10).background(Color.white)
        .overlay(
            HStack{
                Rectangle() // Tag
                    .fill(Color(hex: "D2C7B5"))
                    .frame(width: 10)
                    .alignmentGuide(.leading) { d in d[.leading] }
                Spacer()
            }
        )
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: 4)
    }
}




struct settingOptionCard: View {
    
    var title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: 16)
            HStack{
                Text(title)
                    .font(.custom("Montserrat-Regular", size: 16, relativeTo: .body))
                    .foregroundColor(.black)
                
                Spacer()
                
                Circle()
                    .foregroundColor(Color(hex: "816D54"))
                    .frame(width: 42, height: 42)
                    .overlay(
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white)
                            .font(.system(size: 12))
                    )
            }
            Spacer().frame(height: 16)
            // add line here
            LineShape()
                .stroke(Color(hex: "EEE6DA"), lineWidth: 1)
        }
    }
}







//struct SettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingView()
//    }
//}
