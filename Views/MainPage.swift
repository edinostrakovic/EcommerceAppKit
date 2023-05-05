//
//  MainPage.swift
//  EcommerceAppKit
//
//  Created by home on 30.04.23.
//

import SwiftUI

struct MainPage: View {
    @State var currentTab: Tab = .Home
    
    // Hiding tab bar..
    init(){
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                
                Home()
                    .tag(Tab.Home)
                
                Text("Liked")
                    .tag(Tab.Liked)
                
                ProfilePage()
                    .tag(Tab.Profile)
                
                Text("Cart")
                    .tag(Tab.Cart)
                
                
            }
            //Custom tab bar..
            
            HStack(spacing: 0){
                ForEach(Tab.allCases, id: \.self){tab in
                    Button {
                        currentTab = tab
                        
                    }
                        label: {
                            Image(tab.rawValue)
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 22, height: 22)
                                .background(
                                    Color.purple.opacity(0.1)
                                        .cornerRadius(5)
                                        .blur(radius: 5)
                                        .padding(-7)
                                        .opacity(currentTab == tab ? 1 : 0))
                                .frame(maxWidth: .infinity)
                                .foregroundColor(currentTab == tab ?
                                                 Color.purple :
                                                    Color.black.opacity(0.3))
                            
                        }
                        
                    }
            }
                .padding([.horizontal, .top])
                .padding(.bottom, 10)
        }
        .background(
            Color.gray.opacity(0.1).ignoresSafeArea())
        
        
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

enum Tab: String,CaseIterable{
    
    case Home = "Home"
    case Liked = "Liked"
    case Profile = "Profile"
    case Cart = "Cart"
}
