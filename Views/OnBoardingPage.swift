//
//  OnBoardingPage.swift
//  EcommerceAppKit
//
//  Created by home on 16.04.23.
//

import SwiftUI				

struct OnBoardingPage: View {
    
    // Showing Login Page..
    @State var showLoginPage: Bool = false
    var body: some View {
        VStack {
            
            Text("Find your gadget")
                .font(.title)
                .fontDesign(.rounded)
                .foregroundColor(.black)
                .fontWeight(.bold)
              
            Image("OnBoardingPicture")
                .resizable()
                .aspectRatio(contentMode: .fit)	
                
            Button {
                withAnimation{
                    showLoginPage = true
                }
                
            } label: {
                 Text("Get started")
                    .fontDesign(.rounded)
                    .fontWeight(.semibold)
                    .padding(.vertical, 18)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(.black)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        
        .overlay(
            
                Group {
                    if showLoginPage{
                        LoginPage()
                            .transition(.move(edge: .bottom))
                    }
                }
            )
            
    }
    
    
}

struct OnBoardingPage_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingPage()
    }
}
