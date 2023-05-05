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
            NavigationView{
                StaggeredView(columns: 2, list: homeData.products, content:{ product in
                    ProductCardView(product: product)
                })
                .padding(.horizontal)
                
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
                        .frame(width: getRect().width / 2.5, height: getRect().width / 2.5)
                   
                    
                    Text(product.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding(.top)
                    
//                    Text(product.subtitle)
//                        .font(.footnote)
//                        .foregroundColor(.gray)
                    
//                    Text(product.price)
//                        .font(.headline)
//                        .fontWeight(.bold)
//                        .foregroundColor(.purple)
//                        .padding(.top, 5)
                }
                .padding(.horizontal,20)
                .padding(.bottom,22)
                .background(
                    Color.white
                        .cornerRadius(25)
                )
            }
}

    struct SearchView_Previews: PreviewProvider {
        static var previews: some View {
            Home()
        }
    }
    

