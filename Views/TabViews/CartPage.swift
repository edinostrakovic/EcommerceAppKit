//
//  CartPage.swift
//  EcommerceAppKit
//
//  Created by home on 18.05.23.
//

import SwiftUI

struct CartPage: View {
    @EnvironmentObject var sharedData: SharedDataModel
    
    //Delete option ...
    @State var showDeleteOption: Bool = false
    
    var body: some View {
        NavigationView{
            VStack(spacing: 10){
                ScrollView(.vertical, showsIndicators: false){
                    VStack{
                        
                        HStack{
                            Text("Basket")
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
                            .opacity(sharedData.cartProducts
                                .isEmpty ? 0 : 1)
                        }
                        //checking if liked products are empty
                        if sharedData.cartProducts.isEmpty {
                            
                            Group{
                                Text("No Items added")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .padding(.top, 50)
                                Text("Hit the plus button to save into basket")
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
                                ForEach($sharedData.cartProducts){$product in
                                    
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
                                        CardView(product: $product)
                                    }
                                }
                            }
                            .padding(.top, 25)
                            .padding(.horizontal)
                        }
                        
                    }
                    .padding()
                }
                
                //Showing total and checkout button..
                if !sharedData.cartProducts.isEmpty{
                    
                    Group{
                        HStack{
                            Text("Total")
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            Spacer()
                            Text(sharedData.getTotalPrice())
                                .font(.title2).bold()
                                .foregroundColor(.purple)
                            
                        }
                        Button{
                            
                        }label: {
                            Text("Checkout")
                                .font(.title).bold()
                                .foregroundColor(.white)
                                .padding(.vertical, 18)
                                .frame(maxWidth: .infinity)
                                .background(.purple)
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
                        }
                        .padding(.vertical)
                    }
                    .padding(.horizontal, 25)
                    
                }
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                (Color.gray.opacity(0.2)).ignoresSafeArea()
            )
            
            
            
        }
    }
        func deleteProduct(product:Product){
            if let index = sharedData.cartProducts.firstIndex(where:{ currentProduct in
                
                return product.id == currentProduct.id
            }){
                let _ = withAnimation{
                    //removing..
                    sharedData.cartProducts.remove(at: index)
                }
            }
        }
    
    
    struct CartPage_Previews: PreviewProvider {
        static var previews: some View {
            CartPage()
                .environmentObject(SharedDataModel())
        }
    }
    
    struct CardView: View{
        
        //Making product as Binding so as to update in Real time...
        @Binding var product: Product
        var body: some View {
            
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
                    
                    //                Text("Type: \(product.type.rawValue)")
                    //                    .font(.footnote)
                    //                    .fontWeight(.semibold)
                    //                    .foregroundColor(.gray)
                    //Quantity buttons..
                    HStack(spacing: 10){
                        Text("Quantity: ")
                            .font(.title2)
                            .foregroundColor(.gray)
                        
                        Button{
                            product.quantity = (product.quantity > 0 ? (product.quantity - 1) : 0)
                            
                        } label: {
                            Image(systemName: "minus")
                                .font(.caption)
                                .foregroundColor(.white)
                                .frame(width: 20, height: 20)
                                .background(Color("Quantity"))
                                .cornerRadius(4)
                        }
                        Text("\(product.quantity)")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        
                        Button{
                            product.quantity += 1
                        } label: {
                            Image(systemName: "plus")
                                .font(.caption)
                                .foregroundColor(.white)
                                .frame(width: 20, height: 20)
                                .background(Color("Quantity"))
                                .cornerRadius(4)
                        }
                        
                        
                    }
                    
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                Color.white.cornerRadius(10)
            )
        }
    }
}
