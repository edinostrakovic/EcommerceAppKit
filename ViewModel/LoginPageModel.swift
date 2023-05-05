//
//  LoginPageModel.swift
//  EcommerceAppKit
//
//  Created by home on 22.04.23.
//

import SwiftUI

class LoginPageModel: ObservableObject{
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    
    //Register properties
    @Published var registerUser: Bool = false
    @Published var re_Enter_Password: String = ""
    @Published var showReEnterPassword: Bool = false
    
    //Log status
    @AppStorage("log_Status") var log_Status: Bool = false

    
    func Login() {
        // DO action here
        withAnimation{
            log_Status = true
        }
        
    }
    
    func Register() {
        // DO action here
        withAnimation{
            log_Status = true
        }

    }
    
    func ForgotPassword() {
        // DO action here
    }
}

