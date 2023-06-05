//
//  MakanLagiApp.swift // With navigationView
//  MakanLagi
//
//  Created by Hilary Young on 02/05/2023.
//

import SwiftUI
import Firebase
import LanguageManagerSwiftUI

@main
struct MakanLagiApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            let viewModel = AppViewModel()
            
            LanguageManagerView(.deviceLanguage) {
                ContentView()
                    .environmentObject(viewModel)
            }
            
            //ContentView()
                //.environmentObject(viewModel)
        }
    }
    
    func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .portrait
    }
    
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }
    
}
