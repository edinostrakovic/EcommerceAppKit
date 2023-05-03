//
//  LoginPage.swift
//  EcommerceAppKit
//
//  Created by home on 20.04.23.
//

import SwiftUI

struct LoginPage: View {
    @StateObject var loginData: LoginPageModel = LoginPageModel()	
    var body: some View {
        VStack{
                
                Text("Welcome\nback!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: getRect().height / 3.5)
                    .padding()
                    .background(
                        ZStack{
                            LinearGradient(colors: [
                                
                                Color("LoginCircle"),
                                Color("LoginCircle")
                                    .opacity(0.8),
                                Color(.white)
                            ], startPoint: .top, endPoint: .bottom)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                .padding(.trailing)
                                .offset(y: -25)
                                .ignoresSafeArea()

                            Circle()
                                .strokeBorder(Color.black.opacity(0.3), lineWidth: 3)
                                .frame(width: 30, height: 30)
                                .blur(radius: 2)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                                .padding(30)
                                
                            
                            Circle()
                                .strokeBorder(Color.black.opacity(0.3), lineWidth: 3)
                                .frame(width: 30, height: 30)
                                .blur(radius: 2)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .padding(.leading, 30)
                            
                            
                            
                            
                        }
                    )
            
            ScrollView(.vertical, showsIndicators: false) {
                
                //Login Page Form...
                VStack(spacing: 15){
                    
                    Text("Login")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                
                    // Custom text field
                    CustomTextField(icon: "envelope", title: "Email", hint: "niko.nikic@gmail.com", value: $loginData.email, showPassword: $loginData.showPassword)
                        .padding(.top, 30)
                    
                    CustomTextField(icon: "lock", title: "Password", hint: "123456", value: $loginData.password, showPassword: $loginData.showPassword)
                        .padding(.top, 10)
                    
                    if loginData.registerUser{
                        CustomTextField(icon: "lock", title: "Re-Enter Password", hint: "123456", value: $loginData.re_Enter_Password, showPassword: $loginData.showReEnterPassword)
                            .padding(.top, 10)
                    }
                    
                    Button {
                        
                        loginData.ForgotPassword()
                    } label: {
                        Text("Forgot password?")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                            .foregroundColor(.purple)
                    }
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    Button {
                        
                        if loginData.registerUser{
                            loginData.Register()
                        }
                        else {
                            loginData.Login()
                        }
                        
                    } label: {
                        Text(loginData.registerUser ? "Register" : "Login")
                            .font(.system(size: 17))
                            .fontWeight(.bold)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(.purple)
                            .cornerRadius(15)
                            .shadow(color:
                                        Color.black.opacity(0.07),
                                        radius: 5, x: 5, y: 5)
                    }
                    .padding(.top, 25)
                    .padding(.horizontal)

                    // Register user button
                    Button {
                        withAnimation{
                            loginData.registerUser.toggle()
                        }
                    } label: {
                        Text(loginData.registerUser ?"Back to login" : "Create account")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                            .foregroundColor(.purple)
                    }
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity)
                    
                    
                    
                    
                }
                .padding(30)
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
            .ignoresSafeArea()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.purple)
        
        // Clearing data when Changes..
        // Optional
        .onChange(of: loginData.registerUser){ newValue in
            loginData.email = ""
            loginData.password = ""
            loginData.re_Enter_Password = ""
            loginData.showPassword = false
            loginData.showReEnterPassword = false
        }
    }
    
    @ViewBuilder
    func CustomTextField(icon: String, title: String, hint: String, value: Binding<String>, showPassword: Binding<Bool> )->some View {
        VStack(alignment: .leading, spacing: 12){
            Label{
                Text(title)
                    .font(.system(size: 17))
                
            } icon: {
                Image(systemName: icon)
                
            }
            .foregroundColor(Color.black.opacity(0.8))
            
            
            if title.contains("Password") && !showPassword.wrappedValue{
                SecureField(hint, text: value)
            }
            else {
                TextField(hint, text: value)
            }
            Divider()
                .background(Color.black.opacity(0.4))
        }
        .overlay(
            Group{
                if title.contains("Password"){
                    Button (action: {
                        showPassword.wrappedValue.toggle()
                        
                    }, label: {
                        Text(showPassword.wrappedValue ? "Hide": "Show")
                            .font(.system(size: 17))
                            .fontWeight(.bold)
                            .foregroundColor(.purple)
                    })
                    .offset(y: 8)
                }
            }
            , alignment: .trailing
        )
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}

// extending view to get Screen Bounds...
extension View{
    
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}
