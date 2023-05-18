//
//  LikedPage.swift
//  EcommerceAppKit
//
//  Created by home on 18.05.23.
//

import SwiftUI

struct LikedPage: View {
    //for designing...
    //@EnvironmentObject var homeData: HomeViewModel
    @EnvironmentObject var sharedData: SharedDataModel
    
    //Delete option ...
    @State var showDeleteOption: Bool = false

    var body: some View {
        NavigationView{
            
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    
                    HStack{
                        Text("Favourites")
                            .font(.title).bold()
                        Spacer()
                        Button{
                            withAnimation{
                                showDeleteOption.toggle()
                            }
                            
                        }label: {
                            Image(systemName: "cart.badge.minus")
                                .resizable()
                                .foregroundColor(.red)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                        }
                        .opacity(sharedData.likedProducts
                        .isEmpty ? 0 : 1)
                    }
                    //checking if liked products are empty
                    if sharedData.likedProducts.isEmpty {
                        
                        Group{
                            Text("No favourites yet")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding(.top, 50)
                            Text("Hit the like button on each product page to save favourite ones")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                                .padding(.top, 10)
                                .multilineTextAlignment(.center)
                            
                        }
                    }else{
                        //Displaying products...
                        VStack(spacing: 15){
                            //For designing...
                            ForEach(sharedData.likedProducts){product in
                                
                                HStack(spacing:0){
                                    
                                    if showDeleteOption{
                                        Button{
                                            deleteProduct(product: product)
                                        }label: {
                                            Image(systemName: "minus.circle.fill")
                                                .font(.title2)
                                                .foregroundColor(.red)
                                        }
                                        .padding(.trailing)
                                    }
                                    CardView(product: product)
                                }
                            }
                        }
                        .padding(.top, 25)
                        .padding(.horizontal)
                    }
                    
                }
                .padding()
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                (Color.gray.opacity(0.2)).ignoresSafeArea()
            )
        }
    }
    
    @ViewBuilder
    func CardView(product:Product) -> some View{
        HStack(spacing: 15){
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 8){
                Text(product.title)
                    .font(.title).bold()
                    .lineLimit(1)
                Text(product.subtitle)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.purple)
                
                Text("Type: \(product.type.rawValue)")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Color.white.cornerRadius(10)
        )
    }
    func deleteProduct(product:Product){
        if let index = sharedData.likedProducts.firstIndex(where:{ currentProduct in
            
            return product.id == currentProduct.id
        }){
           let _ = withAnimation{
                //removing..
                sharedData.likedProducts.remove(at: index)
            }
        }
    }
}

struct LikedPage_Previews: PreviewProvider {
    static var previews: some View {
        LikedPage()
            .environmentObject(SharedDataModel())

    }
}
