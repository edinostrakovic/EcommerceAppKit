//
//  StaggeredGrid.swift
//  EcommerceAppKit
//
//  Created by home on 03.05.23.
//

import SwiftUI

struct StaggeredView<Content: View,T: Identifiable>: View where T: Hashable{
    
    // It will return each object from collection to build view..
    var content: (T) -> Content
    var list: [T]
    
    // Columns..
    var columns: Int
    
    //properties
    var showIndicators: Bool
    var spacing: CGFloat
    
    init(columns: Int,showIndicators: Bool = false, spacing: CGFloat = 10, list: [T], @ViewBuilder content: @escaping (T)-> Content){
        self.content = content
        self.list = list
        self.spacing = spacing
        self.showIndicators = showIndicators
        self.columns = columns
    }
    
    
    //Staggered grid function
    func setUpList()->[[T]]{
        //creating empty sub arrays of columns count...
        var gridArray: [[T]] = Array(repeating: [], count: columns)
        
        //spliting array for VStack oriented View..
        var currentIndex: Int = 0
        
        for object in list{
            gridArray[currentIndex].append(object)
            
            //increasing the index count
            // and reseting if overbounds the columns count...
            if currentIndex == (columns - 1){
                currentIndex = 0
            }
            else {
                currentIndex += 1
            }
        }
        
        return gridArray
        
    }
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: showIndicators){
            HStack(alignment: .top){
              
                ForEach(setUpList(),id: \.self){columnsData in
                   
                    LazyVStack(spacing: spacing){
                        ForEach(columnsData){object in
                            content(object)
                        }
                    }

                }
            }
            //only vertical padding...
            //horizontal padding will be user's optional
            .padding(.vertical)
        }
        
    }
}

struct StaggeredGrid_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
