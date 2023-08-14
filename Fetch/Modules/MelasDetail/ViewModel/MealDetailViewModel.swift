//
//  MealDetailViewModel.swift
//  Fetch
//
//  Created by niravkumar patel on 7/26/23.
//

import Foundation

class MealDetailViewModel: ObservableObject {
    
    private let request: HTTPRequestProtocal
    @Published var mealsDetail: MealDetailDataModel?
    @Published var responseError: String?
    
    init(request: HTTPRequestProtocal) {
        self.request = request
    }
    
    //MARK: Methods
    /// fetchMealDetailWith MealID
    ///  Pass Meal id as a String
    func fetchMealDetailWith(mealID: String?) {
        
        if let mealID = mealID, mealID != "" {
            let urlcomponents = URLRequestComponents(components: API.mealsDetail(param: mealID))
            
            request.performRequest(urlRequestComponents: urlcomponents) { [self] result in
                
                switch result {
                case .success(let data):
                    parseData(data)
                    responseError = nil
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        } else {
            self.responseError = "meal id not found"
        }
    }
    
    /// Converting Data into model data 
    private func parseData(_ responseData: Data)  {
        
        do {
            // Decode responsedata to Expactred Model Type
            let mealsDetailParseData = try JSONDecoder().decode(MealDetailModel.self, from: responseData)
            
//            if let meal = mealsDetailParseData.meals?.first {
//                 print("Meal ID: \(meal.idMeal)")
//                 print("Meal Name: \(meal.strMeal)")
//                 print("Category: \(meal.strCategory)")
//                 print("Area: \(meal.strArea)")
//                 print("Instructions: \(meal.strInstructions)")
//                 print("Thumbnail URL: \(meal.strMealThumb)")
//                 print("YouTube URL: \(meal.strYoutube)")
//                 print("Source URL: \(meal.strSource)")
//
//                for (ingredient, measurement) in meal.ingredientsAndMeasurements {
//                        print("\(ingredient) - \(measurement)")
//                    }
//            }
//
            if let arrMealDetail = mealsDetailParseData.meals {
                mealsDetail = arrMealDetail.first
                
                
            } else {
                responseError = "Something went wrong!!!"
            }
        } catch {
            responseError = "Something went wrong!!!"
        }
    }
}
