//
//  SearchView.swift
//  EcommerceAppKit
//
//  Created by home on 03.05.23.
//

import SwiftUI

struct SearchView: View {
    var animation: Namespace.ID
    @EnvironmentObject var homeData: HomeViewModel
    //Activating text field with the help of the FocusState..
    @FocusState var startTF: Bool
    var body: some View {
        
        VStack(spacing: 0){
            //Search bar..
            HStack(spacing: 20){
                
                Button{
                    withAnimation{
                        homeData.searchActivated = false
                    }
                    homeData.searchText = ""
                }label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(Color.black.opacity(0.7))
                }
                //Search bar..
                HStack(spacing: 15){
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: $homeData.searchText)
                        .focused($startTF)
                        .textCase(.lowercase)
                        .autocorrectionDisabled()
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(
                    
                    Capsule()
                        .strokeBorder(Color.purple, lineWidth: 1.5)
                )
                .matchedGeometryEffect(id: "SEARCHTAB", in: animation)
                .padding(.trailing, 20)
            }
            .padding(.horizontal)
            .padding(.top)
            .padding(.bottom, 10)
            
            //Showing progress if searching...
            // else showing no results found if empty...
            
            if let products = homeData.searchedProducts {
                //if empty
                if products.isEmpty{
                    //No results found ...
                    VStack(spacing: 10){
                        
                        Text("Item not found")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top, 20)
                        
                        Text("Try a more generic search term or try looking for alternative products ")
                            .font(.title2)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                        
                    }
                    .padding()
                }
                else{
                    ScrollView(.vertical, showsIndicators: false){
                        
                        VStack(spacing: 0){
                            //found text...
                            Text("Found \(products.count) results")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.vertical)
                            StaggeredView(columns: 2,spacing: 20, list: products, content:{ products in
                                ProductCardView(product: products)
                            })
                            .padding(.horizontal)
                            
                        }
                        .padding()
                    }
                    
                }
                
            }
                else{
                    ProgressView()
                        .padding(.top, 30)
                        .opacity(homeData.searchText == "" ? 0 : 1)
                }
            }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color(red: 219, green: 217, blue: 217))
     
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                startTF = true
            }
        }
}

            
            @ViewBuilder
            func ProductCardView(product: Product) -> some View {
                VStack(spacing: 10){
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .offset(y: -50)
                        .padding(.bottom, -50)
                    
                    Text(product.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding(.top)
                    
                    Text(product.subtitle)
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    Text(product.price)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.purple)
                        .padding(.top, 5)
                }
                .padding(.horizontal,20)
                .padding(.bottom,22)
                .background(
                    Color.white
                        .cornerRadius(25)
                )
                .padding(.top, 50)
            }
    
}

    struct SearchView_Previews: PreviewProvider {
        static var previews: some View {
            Home()
        }
    }
    

