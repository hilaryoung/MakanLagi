//
//  ContentView.swift
//  MakanLagi
//
//  Created by Hilary Young on 02/05/2023.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        
        NavigationView {
            if viewModel.signedIn{
                TabBar2()
                //TabBar()
            }
            else{
                SignInView()
            }
        }
        .accentColor(Color(hex: "F15533"))
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}

struct SignInView: View {
    
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        ZStack{
            Color(hex: "319070").edgesIgnoringSafeArea(.all) // background
            SigninBack()
            //VPBackground()
            VStack (spacing: 0){
                Spacer()
                
                VStack(alignment: .leading){
                    Spacer().frame(height: 32)
                    
                    // MARK: HEADER
                    Group{
                        Text("Sign in")
                            .font(.custom("PlayfairDisplay-Bold", size: 32, relativeTo: .largeTitle))
                            .foregroundColor(Color(hex: "3A290E"))
                        Spacer().frame(height: 12)
                        Text("Please sign in to continue...")
                            //.font(.title3)
                            .font(.custom("Montserrat-Regular", size: 18, relativeTo: .title3))
                    }
                    
                    Spacer().frame(height: 40)
                    
                    // MARK: TEXT FIELDS
                    Group{
                        
                        DefaultTextField(title: "Email", placeholder: "example@email.com", bindingValue: $email)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        
                        Spacer().frame(height: 24)
                        
                        DefaultSecureField(title: "Password", placeholder: "******" ,bindingValue: $password)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        
                        Spacer().frame(height: 40)
                        
                        
                        // MARK: SIGN IN BUTTON
                        Button(action: {
                            guard !email.isEmpty, !password.isEmpty else {
                                return
                            }
                            
                            viewModel.signIn(email: email, password: password)
                            
                        }, label: {
                            HStack{
                                Spacer()
                                DefaultAuthButton(label: "Sign in", backHex: "F15533", textHex: "fff")
                                Spacer()
                            }
                        })
                        
                        // MARK: SIGN UP BUTTON
                        Spacer().frame(height: 24)
                        HStack{
                            Spacer()
                            Text("Don’t have an account?")
                                .font(.custom("Montserrat-Regular", size: 16, relativeTo:.body))
                            NavigationLink("SIGN UP", destination: SignUpView())
                                .foregroundColor(Color(hex: "F15533"))
                                .font(.custom("Montserrat-Bold", size: 16, relativeTo:.body))
                                .transition(.move(edge: .trailing))
                            Spacer()
                        }
                        Spacer().frame(height: 16)
                    }
                    
                    
                }
                .padding()
                .padding(.bottom)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .background(RoundedCorners(color: Color(hex: "FFF9F0"),tl: 30, tr: 30, bl: 0, br: 0))
                
                // Sign up section
                VStack(alignment: .leading){
                    Spacer().frame(height: 2)
                }
                .frame(maxWidth: .infinity)
                .background(Color(hex: "FFF9F0"))
            }
        }
        .navigationBarHidden(true)
    }
}



struct SigninBack: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        GeometryReader { geo in
            VStack{
                ZStack{
                    Image("HangingUtensil")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width, height: geo.size.width)
                        .offset(x:0,y: -155)
                }
            }
        }
    }
}



struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    @State private var firstName = ""
    @State private var lastName = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @State private var isShowingPolicySheet = false
    
    var body: some View {
        let isAllFieldsFilled: Bool = !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && !password.isEmpty
        
        ZStack{
            Color(hex: "319070").edgesIgnoringSafeArea(.all) // background
            SignupBack()
            
            VStack (spacing: 0){
                Spacer()
                
                VStack(alignment: .leading){
                    // MARK: HEADER
                    Group{
                        Spacer().frame(height: 32)
                        
                        Text("Sign up")
                            .font(.custom("PlayfairDisplay-Bold", size: 32, relativeTo: .largeTitle))
                            .foregroundColor(Color(hex: "3A290E"))
                        Spacer().frame(height: 12)
                        Text("Please sign up to continue...")
                        //.font(.title3)
                            .font(.custom("Montserrat-Regular", size: 18, relativeTo: .title3))
                        
                        Spacer().frame(height: 40)
                    }
                    
                    // MARK: Text fields
                    Group{
                        DefaultTextField(title: "First name", placeholder: "Jane", bindingValue: $firstName)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        
                        Spacer().frame(height:24)
                        
                        DefaultTextField(title: "Last name", placeholder: "Doe", bindingValue: $lastName)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        
                        Spacer().frame(height:24)
                        
                        DefaultTextField(title: "Email", placeholder: "example@email.com", bindingValue: $email)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        
                        Spacer().frame(height: 24)
                        
                        DefaultSecureField(title: "Password", placeholder: "******" ,bindingValue: $password)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        
                        Spacer().frame(height: 40)
                    }
                    
                    // MARK: POLICY OPTION // SIGN UP
                    HStack{
                        Spacer()
                        NavigationLink {
                            if isAllFieldsFilled {
                                PrivacySheetView(email: email, password: password, firstName: firstName, lastName: lastName)
                            }
                        } label: {
                            DefaultAuthButton(label: "Sign up", backHex: "F15533", textHex: "fff")
                        }
                        .disabled(!isAllFieldsFilled)
                        Spacer()
                    }

                    
                    
                    // MARK: Sign in
                    Spacer().frame(height: 24)
                    HStack{
                        Spacer()
                        Text("Already have an account?")
                            .font(.custom("Montserrat-Regular", size: 16, relativeTo:.body))
                        NavigationLink("SIGN IN", destination: SignInView())
                            .foregroundColor(Color(hex: "F15533"))
                            .font(.custom("Montserrat-Bold", size: 16, relativeTo:.body))
                            .transition(.move(edge: .trailing))
                        Spacer()
                    }
                    Spacer().frame(height: 16)
                    
                    //end
                }
                .padding()
                .padding(.bottom)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .background(RoundedCorners(color: Color(hex: "FFF9F0"),tl: 30, tr: 30, bl: 0, br: 0))
                
                // Sign up section
                VStack(alignment: .leading){
                    Spacer().frame(height: 2)
                }
                .frame(maxWidth: .infinity)
                .background(Color(hex: "FFF9F0"))
            }
        }
        .navigationBarHidden(true)
        
    }
}


struct SignupBack: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        GeometryReader { geo in
            VStack{
                ZStack{
                    Image("HangingUtensil2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geo.size.width, height: geo.size.width)
                        .offset(x:0,y: -185)
                }
            }
        }
    }
}









struct SignInView2: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack {
            TextField("Email Address", text: $email)
                .padding()
                .disableAutocorrection(true)
                .autocapitalization(.none)
            SecureField("Password", text: $password)
                .padding()
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            Button(action: {
                guard !email.isEmpty, !password.isEmpty else {
                    return
                }
                
                viewModel.signIn(email: email, password: password)
                
            }, label: {
                Text("Sign In")
                    .frame(width: 200, height: 50)
                    .cornerRadius(8)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
            })

            
            NavigationLink("Create account", destination: SignUpView())

            Spacer()
        }
        .navigationTitle("Sign In")
    }
}



struct SignUpView2: View {
    @State var email = ""
    @State var password = ""
    @State private var firstName = ""
    @State private var lastName = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack {
            TextField("First-name", text: $firstName)
                .padding()
            TextField("Last-name", text: $lastName)
                .padding()
            
            TextField("Email Address", text: $email)
                .padding()
                .disableAutocorrection(true)
                .autocapitalization(.none)
            SecureField("Password", text: $password)
                .padding()
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            Button(action: {
                guard !email.isEmpty, !password.isEmpty else {
                    return
                }
                
                viewModel.signUp(email: email, password: password, firstName: firstName, lastName: lastName)
                
            }, label: {
                Text("Create account")
                    .frame(width: 200, height: 50)
                    .cornerRadius(8)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
            })


            
            Spacer()
        }
        .navigationTitle("Create account")
    }
}



//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environmentObject(AppViewModel())
//    }
//}
