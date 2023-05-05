//
//  HomeViewModel.swift
//  EcommerceAppKit
//
//  Created by home on 02.05.23.
//

import SwiftUI


//Using combine to monitor search field and if user leaves for .5 secs then starts searching...
//to avoid memory issue...
import Combine

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
    @Published var searchedProducts: [Product]?
    
    var searchCancellable: AnyCancellable?
    
    init() {
        filterProductbyType()
        searchCancellable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: {str in
                
                if str != "" {
                    self.filterProductbySearch()
                }
                else{
                    self.searchedProducts = nil
                }
            })
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
    
    func filterProductbySearch() {
        //Filtering products by product type...
        DispatchQueue.global(qos: .userInteractive).async {
            
            let results = self.products
            //since it will require more memory we use lazy to perform more..
                .lazy
                .filter {product in
                    return product.title.lowercased().contains(self.searchText.lowercased())
                }
           
            DispatchQueue.main.async {
                self.searchedProducts = results.compactMap({product in
                    
                    return product
                })
            }
        }
    }
}
