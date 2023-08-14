//
//  MealsListView.swift
//  Fetch
//
//  Created by niravkumar patel on 7/26/23.
//

import SwiftUI

struct MealsListView: View {
    
    @ObservedObject var mealsListViewModel = MealsListViewModel(request: HTTPRequest())
    
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical) {
                VStack {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 3), count: 2)) {
                            
                            ForEach(mealsListViewModel.mealsList) { meal in
                                NavigationLink {
                                    MealsDetail(mealID: meal.id ?? "")
                                        .navigationTitle("Meal Detail")
                                } label: {
                                    MealsView(image: "\(meal.image ?? "")", title: meal.title ?? "Unknown")
                                }
                            }
                            .padding(.bottom,5)
                        }
                } // VStack
            }// ScrollView
            .padding(.horizontal)
            .navigationTitle("Meals")
            .task {
                mealsListViewModel.fetchMealsListWith("Dessert")
            }// Perform API Task
        }// NavigationView
    }
}

struct MealsListView_Previews: PreviewProvider {
    static var previews: some View {
        MealsListView()
    }
}
