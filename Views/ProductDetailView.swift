//
//  ProductDetailView.swift
//  EcommerceAppKit
//
//  Created by home on 05.05.23.
//

import SwiftUI

struct ProductDetailView: View {
    var product: Product
    
    //For Matched geometry effect...
    var animation: Namespace.ID
    
    //Shared data model...
    @EnvironmentObject var sharedData: SharedDataModel
    @EnvironmentObject var homeData: HomeViewModel
    var body: some View {
        
        VStack{
            
            //Title bar and product image.
            VStack{
                
                HStack{
                    Button{
                        //Closing View...
                        withAnimation(.easeInOut){
                            sharedData.showDetailProduct = false
                        }
                    }label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(Color.black.opacity(0.7))
                    }
                    Spacer()
                    Button{
                        addToLiked()
                        
                    }label: {
                        Image("Liked")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .foregroundColor(isLiked() ? .red :
                                Color.black.opacity(0.7))
 
                    }
                }
                .padding(.top, 50)
                .padding(.horizontal, 20)
                 
                
                //Product image...
                //Adding matched geometry...
                Image(product.productImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "\(product.id)\(sharedData.fromSearchPage ? "SEARCH" : "IMAGE")", in: animation)
                    .padding(.horizontal)
                    .offset(y: -12)
                    .frame(maxHeight: .infinity)
                
            }
            .frame(height: getRect().height / 2.7)
            .zIndex(1)
            .background(Color.gray.opacity(0.2)).ignoresSafeArea()
            

            //product details...
            ScrollView(.vertical, showsIndicators: false){
                
                //Product data..
                VStack(alignment: .leading, spacing: 15){
                    Text(product.title).font(.title).bold()
                    Text(product.subtitle).font(.title2).foregroundColor(.gray)
                    Text("Get Apple TV free for a year!")
                        .font(.title2).bold()
                        .padding(.top)
                    
                    Text("Available when you purchase any new iPhone, iPad, iPod Touch, Mac or Apple TV, $4.99/month after free trial.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Button{
                        
                    }label: {
                        
                        //Since we need image at right..
                        Label{
                            Image(systemName: "arrow.right")
                        } icon: {
                            Text("Full description")
                        }
                        .font(.subheadline).bold()
                        .foregroundColor(.purple)
                        
                    }
                    
                    HStack{
                        Text("Total")
                            .font(.title2)
                        
                        Spacer()
                        
                        Text("\(product.price)")
                            .font(.title2).bold()
                            .foregroundColor(.purple)
                    }
                    .padding(.vertical, 20)
                    
                    
                    //Add button...
                    Button{
                        addToCart()
                    }label: {
                        Text("\(isAddedToCart() ? "added" : "add") to basket")
                            .font(.caption).bold()
                            .foregroundColor(.white)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .background(
                                Color.purple.cornerRadius(15))
                            .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                    }

                }
                .padding([.horizontal, .bottom], 25)
                .padding(.top, 25)
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                //Corner radius only for the top side..
                    .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
                    .ignoresSafeArea()
            )
            .zIndex(0)
        }
        .animation(.easeInOut, value: sharedData.likedProducts)
        .animation(.easeInOut, value: sharedData.cartProducts)
        .background(Color(red: 115, green: 114, blue: 111)).ignoresSafeArea()
    }
    
    func isLiked()-> Bool{
        return sharedData.likedProducts.contains {product in
            return self.product.id == product.id
        }
    }
    func isAddedToCart()-> Bool{
        return sharedData.cartProducts.contains {product in
            return self.product.id == product.id
        }
    }
    
    func addToLiked(){
        if let index = sharedData.likedProducts.firstIndex(where: {product in
            return self.product.id == product.id
        }){
            sharedData.likedProducts.remove(at: index)
        }else{
            //add to liked...
            sharedData.likedProducts.append(product)
        }
    }
    func addToCart(){
        if let index = sharedData.cartProducts.firstIndex(where: {product in
            return self.product.id == product.id
        }){
            sharedData.cartProducts.remove(at: index)
        }else{
            //add to liked...
            sharedData.cartProducts.append(product)
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        //Sample product for building preview...
        //        ProductDetailView(product: HomeViewModel().products[0])
        //            .environmentObject(SharedDataModel())
    MainPage()
        
    }
}
