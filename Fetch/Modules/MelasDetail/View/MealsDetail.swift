//
//  MealsDetail.swift
//  Fetch
//
//  Created by niravkumar patel on 7/26/23.
//

import SwiftUI

struct MealsDetail: View {
    
    let mealID: String
    var body: some View {
        
        VStack {
            ScrollView(.vertical) {
                DetailView(id: mealID)
            }
        }
    }
}

struct MealsDetail_Previews: PreviewProvider {
    static var previews: some View {
        MealsDetail(mealID: "53049")
    }
}

struct DetailView: View {
    
    @ObservedObject var mealDetailViewModel = MealDetailViewModel(request: HTTPRequest())
    let id: String
    
    var body: some View {
        VStack(alignment: .leading) {
            
            AsyncImage(url: URL(string: mealDetailViewModel.mealsDetail?.strMealThumb ?? "")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .aspectRatio(contentMode: .fit)
            .padding(.bottom)
            
            Text(mealDetailViewModel.mealsDetail?.strMeal ?? "")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.horizontal)
                .padding(.bottom,3)
            
            Group {
                Text("Instruction")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                
                Text(mealDetailViewModel.mealsDetail?.strInstructions ?? "")
                    .padding(.top,1)
                    .padding([.bottom,.horizontal])
            }
            
            Text("Measurements")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.horizontal)
            
            /// Measurement and ingredients View
            
            Group {
                MeasurementView(ingredient: mealDetailViewModel.mealsDetail?.strIngredient1 ?? "", measure: mealDetailViewModel.mealsDetail?.strMeasure1 ?? "")
                MeasurementView(ingredient: mealDetailViewModel.mealsDetail?.strIngredient2 ?? "", measure: mealDetailViewModel.mealsDetail?.strMeasure2 ?? "")
                MeasurementView(ingredient: mealDetailViewModel.mealsDetail?.strIngredient3 ?? "", measure: mealDetailViewModel.mealsDetail?.strMeasure3 ?? "")
                MeasurementView(ingredient: mealDetailViewModel.mealsDetail?.strIngredient4 ?? "", measure: mealDetailViewModel.mealsDetail?.strMeasure4 ?? "")
                MeasurementView(ingredient: mealDetailViewModel.mealsDetail?.strIngredient5 ?? "", measure: mealDetailViewModel.mealsDetail?.strMeasure5 ?? "")
                MeasurementView(ingredient: mealDetailViewModel.mealsDetail?.strIngredient6 ?? "", measure: mealDetailViewModel.mealsDetail?.strMeasure6 ?? "")
                MeasurementView(ingredient: mealDetailViewModel.mealsDetail?.strIngredient7 ?? "", measure: mealDetailViewModel.mealsDetail?.strMeasure7 ?? "")
                MeasurementView(ingredient: mealDetailViewModel.mealsDetail?.strIngredient8 ?? "", measure: mealDetailViewModel.mealsDetail?.strMeasure8 ?? "")
                MeasurementView(ingredient: mealDetailViewModel.mealsDetail?.strIngredient9 ?? "", measure: mealDetailViewModel.mealsDetail?.strMeasure9 ?? "")
                MeasurementView(ingredient: mealDetailViewModel.mealsDetail?.strIngredient10 ?? "", measure: mealDetailViewModel.mealsDetail?.strMeasure10 ?? "")
            }
            
            Group {
                
                MeasurementView(ingredient: mealDetailViewModel.mealsDetail?.strIngredient11 ?? "", measure: mealDetailViewModel.mealsDetail?.strMeasure11 ?? "")
                MeasurementView(ingredient: mealDetailViewModel.mealsDetail?.strIngredient12 ?? "", measure: mealDetailViewModel.mealsDetail?.strMeasure12 ?? "")
                MeasurementView(ingredient: mealDetailViewModel.mealsDetail?.strIngredient13 ?? "", measure: mealDetailViewModel.mealsDetail?.strMeasure13 ?? "")
                MeasurementView(ingredient: mealDetailViewModel.mealsDetail?.strIngredient14 ?? "", measure: mealDetailViewModel.mealsDetail?.strMeasure14 ?? "")
                MeasurementView(ingredient: mealDetailViewModel.mealsDetail?.strIngredient15 ?? "", measure: mealDetailViewModel.mealsDetail?.strMeasure15 ?? "")
                MeasurementView(ingredient: mealDetailViewModel.mealsDetail?.strIngredient16 ?? "", measure: mealDetailViewModel.mealsDetail?.strMeasure16 ?? "")
                MeasurementView(ingredient: mealDetailViewModel.mealsDetail?.strIngredient17 ?? "", measure: mealDetailViewModel.mealsDetail?.strMeasure17 ?? "")
                MeasurementView(ingredient: mealDetailViewModel.mealsDetail?.strIngredient18 ?? "", measure: mealDetailViewModel.mealsDetail?.strMeasure18 ?? "")
                MeasurementView(ingredient: mealDetailViewModel.mealsDetail?.strIngredient19 ?? "", measure: mealDetailViewModel.mealsDetail?.strMeasure19 ?? "")
                MeasurementView(ingredient: mealDetailViewModel.mealsDetail?.strIngredient20 ?? "", measure: mealDetailViewModel.mealsDetail?.strMeasure20 ?? "")
            } // Group
            
            
        }// VStack
        .padding(.bottom)
        .task {
            mealDetailViewModel.fetchMealDetailWith(mealID: id)
        }
    }
}
