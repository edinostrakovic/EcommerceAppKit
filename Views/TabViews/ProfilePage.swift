//
//  ProfilePage.swift
//  EcommerceAppKit
//
//  Created by home on 05.05.23.
//

import SwiftUI

struct ProfilePage: View {
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical,showsIndicators: false){
                VStack{
                    
                    Text("My Profile")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(spacing: 15){
                        Image("Profile_Image")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .offset(y: -30)
                            .padding(.bottom, -30)
                        
                        
                            .padding([.horizontal,.bottom])
                        Text("John Doe")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        
                        HStack(alignment: .top, spacing: 10){
                            
                            Image(systemName: "location.north.circle.fill")
                                .foregroundColor(.gray)
                                .rotationEffect(.init(degrees: 180))
                            
                            Text("Address: 123 Maple Street\nAnyTown, PA 17101")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        
                    }
                    .padding([.horizontal, .bottom])
                    .background(
                        Color.white
                            .cornerRadius(12)
                    )
                    .padding()
                    .padding(.top, 40)
                    
                    CustomNavigationLink(title: "Edit Profile"){
                        Text("")
                            .navigationTitle("Edit Profile")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background((Color.gray.opacity(0.15)).ignoresSafeArea())
                    }
                    CustomNavigationLink(title: "Shipping Address"){
                        Text("")
                            .navigationTitle("Shipping Address")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background((Color.gray.opacity(0.15)).ignoresSafeArea())
                    }
                    CustomNavigationLink(title: "Order History"){
                        Text("")
                            .navigationTitle("Order History")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background((Color.gray.opacity(0.15)).ignoresSafeArea())
                    }
                    CustomNavigationLink(title: "Cards"){
                        Text("")
                            .navigationTitle("Cards")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background((Color.gray.opacity(0.15)).ignoresSafeArea())
                    }
                    CustomNavigationLink(title: "Notifications"){
                        Text("")
                            .navigationTitle("Notifications")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background((Color.gray.opacity(0.15)).ignoresSafeArea())
                    }
                    
                    
                    
                }
                .padding(.horizontal, 22)
                .padding(.vertical, 20)
                
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background((Color.gray.opacity(0.15)).ignoresSafeArea())

            
            
        }
    }
    
    //Avoiding new structs...
    @ViewBuilder
    func CustomNavigationLink<Detail: View>(title: String, @ViewBuilder content:
         @escaping ()->Detail)-> some View{
        
        NavigationLink{
            content()
        } label: {
            HStack{
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
            Spacer()
            
            Image(systemName: "chevron.right")
            }
            .foregroundColor(.black)
            .padding()
            .background(
            
                Color.white
                    .cornerRadius(12)
            )
            .padding(.horizontal)
            .padding(.top, 10)
        }
        
    }
}
struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
