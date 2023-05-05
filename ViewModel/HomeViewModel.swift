//
//  HomeViewModel.swift
//  EcommerceAppKit
//
//  Created by home on 02.05.23.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var productType: ProductType = .Wearable
    
    //Sample products..
    @Published var products: [Product] = [
    
        Product(type: .Wearable, title: "Apple Watch", subtitle: "Series 6: Red", price: "$359", productImage:"AppleWatch6"),
        Product(type: .Wearable, title: "Samsung Watch", subtitle: "Gear: Black", price: "$180", productImage:"SamsungWatch"),
        Product(type: .Wearable, title: "Apple Watch", subtitle: "Series 4: Black", price: "259", productImage:"AppleWatch4"),
        Product(type: .Phones, title: "iPhone 13", subtitle: "A15 - Pink", price: "$699", productImage:"iPhone13"),
        Product(type: .Phones, title: "iPhone 12", subtitle: "A14 - Blue", price: "$599", productImage:"iPhone12"),
        Product(type: .Laptops, title: "Macbook Air", subtitle: "M1 - Gold", price: "$999", productImage:"MacbookAir"),
        Product(type: .Laptops, title: "Macbook Pro", subtitle: "M1 - Space Gray", price: "$999", productImage:"MacbookPro"),
      //  Product(type: .Wearable, title: "Apple Watch", subtitle: "Series 6: Red", price: "$359", productImage:"AppleWatch6")
      //  Product(type: .Wearable, title: "Apple Watch", subtitle: "Series 6: Red", price: "$359", productImage:"AppleWatch6")
        
    
    
    
    ]
    
    
    //Filtered products
    @Published var filteredProducts:[Product] = []
    
    //More products on the type
    @Published var showMoreProductsOnType: Bool = false
    
    @Published var searchText: String = ""
    @Published var searchActivated: Bool = false

    
    init() {
        filterProductbyType()
    }
    
    func filterProductbyType() {
        //Filtering products by product type...
        DispatchQueue.global(qos: .userInteractive).async {
            
            let results = self.products
            //since it will require more memory we use lazy to perform more..
                .lazy
                .filter {product in
                    return product.type == self.productType
                }
            //limitating results..
                .prefix(4)
            DispatchQueue.main.async {
                self.filteredProducts = results.compactMap({product in
                    
                    return product
                })
            }
        }
    }
}
