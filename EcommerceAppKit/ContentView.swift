//
//  ContentView.swift
//  EcommerceAppKit
//
//  Created by home on 16.04.23.
//

import SwiftUI

struct ContentView: View {
    //log status..
    @AppStorage("log Status") var log_Status: Bool = false
    var body: some View {
        Group{
            if log_Status{
                MainPage()
            }
            else{
                OnBoardingPage() 
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
