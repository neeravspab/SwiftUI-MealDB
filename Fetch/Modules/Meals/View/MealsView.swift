//
//  MealsView.swift
//  Fetch
//
//  Created by niravkumar patel on 7/26/23.
//

import SwiftUI

struct MealsView: View {
    
    let image:String
    let title:String
       
       var body: some View {
           VStack() {
               
               AsyncImage(url: URL(string: image)) { image in
                   image.resizable()
               } placeholder: {
                   ProgressView()
               }
               .aspectRatio(contentMode: .fill)
               .cornerRadius(20)
               
               Text(title)
                   .padding([.bottom])
           }
           .foregroundStyle(Color(.label))
           
           .frame(width: 170)
           .frame(height: 210)
           .background(Color(.systemBackground))
           .cornerRadius(20)
       }
}
