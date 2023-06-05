//
//  PrivacySheetView.swift
//  MakanLagi
//
//  Created by Hilary Young on 31/05/2023.
//

import SwiftUI

struct PrivacySheetView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isToggleOn = false
    
    let email: String
        let password: String
        let firstName: String
        let lastName: String
    
    
    var body: some View {
        ZStack{
            Color(hex: "FFF9F0").edgesIgnoringSafeArea(.all) // background color
            
            ScrollView{
                VStack(alignment: .leading){
                    
                    // MARK: Header
                    Group{
                        Spacer().frame(height: 24)
                        Text("Privacy Policy")
                            .font(.custom("PlayfairDisplay-Bold", size: 28, relativeTo: .title))
                            .foregroundColor(Color(hex: "3A290E"))
                            .fontWeight(.bold)
                        Spacer().frame(height: 8)
                        Text("Please read these terms carefully before using our mobile application:")
                            .font(.custom("Montserrat-Regular", size: 18, relativeTo: .title3))
                        Spacer().frame(height: 40)
                    }

                    
                    // MARK: Content
                    Group{
                        Text("1. Information Collection")
                            .font(.custom("Montserrat-Regular", size: 18, relativeTo: .title3))
                            .foregroundColor(Color(hex: "3A290E"))
                            .bold()
                        Spacer().frame(height: 8)
                        Text(
                            "We may collect and store certain personal information, such as your name and email address, to provide you with a personalised experience within the App."
                        )
                        .font(.custom("Montserrat-Regular", size: 14, relativeTo: .body))
                        .lineSpacing(8)
                        
                        Spacer().frame(height: 24)
                    }
                    
                    
                    Group{
                        Text("2. Data Storage")
                            .font(.custom("Montserrat-Regular", size: 18, relativeTo: .title3))
                            .foregroundColor(Color(hex: "3A290E"))
                            .bold()
                        Spacer().frame(height: 8)
                        Text(
                            "By using the App, you consent to the storage of your personal information in a Firebase cloud database. We take appropriate measures to ensure the security and confidentiality of your data."
                        )
                        .font(.custom("Montserrat-Regular", size: 14, relativeTo: .body))
                        .lineSpacing(8)
                        
                        Spacer().frame(height: 24)
                    }
                    
                    
                    Group{
                        Text("3. Information Usage")
                            .font(.custom("Montserrat-Regular", size: 18, relativeTo: .title3))
                            .foregroundColor(Color(hex: "3A290E"))
                            .bold()
                        Spacer().frame(height: 8)
                        Text(
                            "We may use your personal information to enhance your user experience, improve our services, and communicate with you regarding updates or relevant information related to the App."
                        )
                        .font(.custom("Montserrat-Regular", size: 14, relativeTo: .body))
                        .lineSpacing(8)
                        
                        Spacer().frame(height: 24)
                    }
                    
                    
                    Group{
                        Text("4. Third-Party Services")
                            .font(.custom("Montserrat-Regular", size: 18, relativeTo: .title3))
                            .foregroundColor(Color(hex: "3A290E"))
                            .bold()
                        Spacer().frame(height: 8)
                        Text(
                            "We may engage with third-party services to assist in data storage, analysis, or other purposes. These third-party services are required to adhere to strict privacy and security standards."
                        )
                        .font(.custom("Montserrat-Regular", size: 14, relativeTo: .body))
                        .lineSpacing(8)
                        
                        Spacer().frame(height: 24)
                    }
                    
                    
                    Group{
                        Text("5. Information Disclosure")
                            .font(.custom("Montserrat-Regular", size: 18, relativeTo: .title3))
                            .foregroundColor(Color(hex: "3A290E"))
                            .bold()
                        Spacer().frame(height: 8)
                        Text(
                            "We do not sell, trade, or transfer your personal information to outside parties without your consent, except as required by law or as necessary to protect our rights or the rights of other users."
                        )
                        .font(.custom("Montserrat-Regular", size: 14, relativeTo: .body))
                        .lineSpacing(8)
                        
                        Spacer().frame(height: 24)
                    }
                    
                    
                    Group{
                        Text("6. Data Retention")
                            .font(.custom("Montserrat-Regular", size: 18, relativeTo: .title3))
                            .foregroundColor(Color(hex: "3A290E"))
                            .bold()
                        Spacer().frame(height: 8)
                        Text(
                            "We retain your personal information for as long as necessary to fulfill the purposes outlined in this privacy policy unless a longer retention period is required or permitted by law."
                        )
                        .font(.custom("Montserrat-Regular", size: 14, relativeTo: .body))
                        .lineSpacing(8)
                        
                        Spacer().frame(height: 24)
                    }
                    
                    
                    Group{
                        Text("7. Your Rights")
                            .font(.custom("Montserrat-Regular", size: 18, relativeTo: .title3))
                            .foregroundColor(Color(hex: "3A290E"))
                            .bold()
                        Spacer().frame(height: 8)
                        Text(
                            "You have the right to access, update, or delete your personal information stored in the App's database. Please contact us at contact.makanlagi@gmail.com for assistance with any inquiries or requests."
                        )
                        .font(.custom("Montserrat-Regular", size: 14, relativeTo: .body))
                        .lineSpacing(8)
                        
                        Spacer().frame(height: 24)
                    }
                    
                    Group{
                        Spacer().frame(height:32)
                        
                        Toggle("I have read and agreed to the terms", isOn: $isToggleOn)
                            .font(.custom("Montserrat-SemiBold", size: 16, relativeTo: .body))
                        
                        Spacer().frame(height: 80)
                        
                    }
                    
                    
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                
            }
            VStack{
                Spacer()
                
                VStack{
                    Spacer().frame(height:16)
                    HStack{
                        // MARK: Update leftover meal
                        Button(action: {
                            print("button is clicked")
                            guard !email.isEmpty, !password.isEmpty else {
                                return
                            }
                            viewModel.signUp(email: email, password: password, firstName: firstName, lastName: lastName)
                            
                        }) {
                            DefaultActiveButton(
                                label: "Continue",
                                backHex: isToggleOn ? "F15533" : "FAC3B8",
                                textHex: "fff"
                            )
                            
                        }
                        .onTapGesture {
                            if isToggleOn {
                                // Perform action when the Confirm button is tapped
                            }
                        }
                        .disabled(!isToggleOn)
                        
                    }
                }
                .padding(.horizontal,16)
                .background(Color(hex: "FFF9F0"))
            }
            .padding(0)
            
            .onAppear {
                // content
            }
        }
    }
}

//struct PrivacySheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        PrivacySheetView()
//    }
//}
