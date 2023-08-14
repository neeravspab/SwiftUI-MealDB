//
//  MeasurementView.swift
//  Fetch
//
//  Created by niravkumar patel on 7/29/23.
//

import SwiftUI

struct MeasurementView: View {
    
    var ingredient:String
    var measure:String
    
    var body: some View {
        
        if !ingredient.isEmpty || !measure.isEmpty {
            if ingredient == " " || measure == " " {
                EmptyView()
            } else {
                Text("\(ingredient) / \(measure)")
                    .padding(.top,1)
                    .padding([.horizontal])
            }
        } else {
            EmptyView()
        }
    }
}

struct MeasurementView_Previews: PreviewProvider {
    static var previews: some View {
        MeasurementView(ingredient: "Banana", measure: "1 Large")
    }
}
