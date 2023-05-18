//
//  SharedDataModel.swift
//  EcommerceAppKit
//
//  Created by home on 17.05.23.
//

import SwiftUI

class SharedDataModel: ObservableObject {
    
    //Detail product data...
    @Published var detailProduct: Product?
    @Published var showDetailProduct: Bool = false
    
    
  //Matched Geometry effect from Search page...
    @Published var fromSearchPage: Bool = false
    
  //Liked products...
    @Published var likedProducts : [Product] = []
    
  //basket products
    @Published var cartProducts : [Product] = []

  //Calculating total price...
    func getTotalPrice()->String{
        var total: Int = 0
        
        cartProducts.forEach{product in
            
            let price = product.price.replacingOccurrences(of: "$", with: "") as NSString
            let quantity = product.quantity
            let priceTotal = quantity * price.integerValue
            
            total += priceTotal
        }
        return "$\(total)"
    }
}

