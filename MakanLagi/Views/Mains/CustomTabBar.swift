//
//  Extra.swift
//  MakanLagi
//
//  Created by Hilary Young on 04/05/2023.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case house
    case bubblesAndSparkles = "bubbles.and.sparkles"
    case leftoverBag = "takeoutbag.and.cup.and.straw"
    case gearshape
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    
    private var tabColor: Color {
        switch selectedTab {
        case .house:
            return .white
        case .bubblesAndSparkles:
            return .white
        case .leftoverBag:
            return .white
        case .gearshape:
            return .white
        }
    }
    
    private var tabColorBack: Color {
        switch selectedTab {
        case .house:
            return Color(hex: "F15533")
        case .bubblesAndSparkles:
            return Color(hex: "F15533")
        case .leftoverBag:
            return Color(hex: "F15533")
        case .gearshape:
            return Color(hex: "F15533")
        }
    }
    
    private var tabName: String {
        switch selectedTab {
        case .house:
            return "Home"
        case .bubblesAndSparkles:
            return "Reinvent"
        case .leftoverBag:
            return "Pantry"
        case .gearshape:
            return "Settings"
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    
                    HStack {
                        Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                            .scaleEffect(tab == selectedTab ? 0.95 : 1.15)
                            .foregroundColor(tab == selectedTab ? tabColor : Color(hex: "B2ADA2"))
                            .font(.system(size: 20))
                            .frame(width: 32)
                            .aspectRatio(contentMode: .fit)
                        
                        if selectedTab == tab {
                            Text(tabName)
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                                .lineLimit(1)
                        }
                    }
                    .padding(.horizontal,14)
                    .padding(.vertical,12)
                    .background(tab == selectedTab ? tabColorBack : Color.clear)
                    .cornerRadius(10000)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            selectedTab = tab
                        }
                    }
                    Spacer()
                }
            }

            //.frame(height: 60)
            .padding(.top, 8)
            .padding(.bottom, 4)
            .background(Color(hex: "FFFAF3"))
            //.cornerRadius(10000)
            //.padding(.horizontal)
            //.padding(.bottom, 8)
            .shadow(color: Color.black.opacity(0.12), radius: 8, x: 0, y: 4) // set the opacity to 16%
        }
    }
}






struct TabBar2: View {
    @State private var tabSelected: Tab = .house
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        //NavigationView{
            ZStack {
                VStack {
                    TabView(selection: $tabSelected) {
                        ForEach(Tab.allCases, id: \.rawValue) { tab in
                            switch tab {
                            case .house:
                                NavigationView {
                                    HomeView()
                                }
                                .tabItem {
                                    Image(systemName: tab.rawValue)
                                    Text("\(tab.rawValue.capitalized)")
                                }
                                .tag(tab)
                            case .bubblesAndSparkles:
                                NavigationView {
                                    ReinventView()
                                }
                                .tabItem {
                                    Image(systemName: tab.rawValue)
                                    Text("\(tab.rawValue.capitalized)")
                                }
                                .tag(tab)
                                
                            case .leftoverBag:
                                NavigationView {
                                    VirtualPantryView()
                                }
                                .tabItem {
                                    Image(systemName: tab.rawValue)
                                    Text("\(tab.rawValue.capitalized)")
                                }
                                .tag(tab)
                            case .gearshape:
                                NavigationView {
                                    SettingView()
                                }
                                .tabItem {
                                    Image(systemName: tab.rawValue)
                                    Text("\(tab.rawValue.capitalized)")
                                }
                                .tag(tab)
                            }
                        }
                    }

                }
                VStack {
                    Spacer()
                    CustomTabBar(selectedTab: $tabSelected)
                }
            }
        //}
    }
}
