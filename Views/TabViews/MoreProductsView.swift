//
//  MoreProductsView.swift
//  EcommerceAppKit
//
//  Created by home on 02.05.23.
//

import SwiftUI

struct MoreProductsView: View {
    var body: some View {
        
        VStack {
            Text("More Products")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.gray.opacity(0.1).ignoresSafeArea())
        
    }
}

struct MoreProductsView_Previews: PreviewProvider {
    static var previews: some View {
        MoreProductsView()
    }
}
