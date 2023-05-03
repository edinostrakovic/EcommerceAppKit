//
//  Home.swift
//  EcommerceAppKit
//
//  Created by home on 30.04.23.
//

import SwiftUI

struct Home: View {
    @Namespace var animation
    @StateObject var homeData: HomeViewModel = HomeViewModel()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                //Search bar..
                HStack(spacing: 15){
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: .constant(""))
                        .disabled(true)
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(
                    
                    Capsule()
                        .strokeBorder(Color.gray, lineWidth: 0.8)
                )
                .frame(width: getRect().width / 1.6)
                .padding(.horizontal, 25)
                Text("Order online\ncollect in store")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal, 25)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 18){
                        
                        ForEach(ProductType.allCases, id: \.self){type in
                            
                            //Product type View..
                            ProductTypeView(type: type)
                        }
                        
                    }
                    .padding(.horizontal, 25)
                }
                .padding(.top, 28)
                
                //Products Page..
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack(spacing: 25) {
                        ForEach(homeData.filteredProducts){product in
                            //product card view..
                            ProductCardView(product: product)
                            
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.bottom)
                    .padding(.top, 80)
                }
                .padding(.top, 30)
                
                Button {
                    homeData.showMoreProductsOnType.toggle()
                } label: {
                    Label {
                        Image(systemName: "arrow.right")
                    }icon: {
                        Text("see more")
                    }
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.purple)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing)
                .padding(.top, 10)
            }
            .padding(.vertical)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray.opacity(0.15))
        //updating data whenever tab changes..
        .onChange(of: homeData.productType){ newValue in
            homeData.filterProductbyType()
        }
        .sheet(isPresented: $homeData.showMoreProductsOnType){
        }content: {
            MoreProductsView()
        }
    }
        
        @ViewBuilder
        func ProductCardView(product: Product) -> some View {
            VStack(spacing: 10){
                Image(product.productImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: getRect().width / 2.5, height: getRect().width / 2.5)
                //Moving image to top to look like its fixed at half top
                    .offset(y: -80)
                    .padding(.bottom, -80)
                
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
        }
        
        @ViewBuilder
        func ProductTypeView(type: ProductType) -> some View {
            
            Button {
                withAnimation{
                    homeData.productType = type
                }
            }
        label: {
            Text(type.rawValue)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(homeData.productType == type ? Color.purple : Color.gray)
                .padding(.bottom, 10)
                .overlay(
                    ZStack{
                        if homeData.productType == type{
                            Capsule()
                                .fill(Color.purple)
                                .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
                                .frame(height: 2)
                        }
                        else {
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 2)
                        }
                    }
                        .padding(.horizontal, -5)
                    ,alignment: .bottom
                )
            
        }
            
        }
    }

    struct Home_Previews: PreviewProvider {
        static var previews: some View {
            Home()
        }
    }

