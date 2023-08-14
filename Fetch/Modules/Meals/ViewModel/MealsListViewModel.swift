//
//  MealsListViewModel.swift
//  Fetch
//
//  Created by niravkumar patel on 7/26/23.
//

import Foundation

class MealsListViewModel: ObservableObject {
    
    private let request: HTTPRequestProtocal
    @Published var mealsList:[MealsList] = []
    @Published var responseError: String?
    
    init(request: HTTPRequestProtocal) {
        self.request = request
    }
    
    //MARK: Methods
    /// fetchMeal List with category
    ///  Pass category id as a String
    
    func fetchMealsListWith(_ category: String?) {
        
        if let category = category, category != "" {
            let urlcomponents = URLRequestComponents(components: API.meals(param: category))
            
            request.performRequest(urlRequestComponents: urlcomponents) { [self] result in
                
                switch result {
                case .success(let data):
                    parseData(data)
                    responseError = nil
                case .failure(let error):
                    print(error.localizedDescription)
                    responseError = error.localizedDescription
                }
            }
        } else {
            self.responseError = "category not found"
        }
    }
    
    /// Converting Data into model data 
    private func parseData(_ responseData: Data?)  {
        
        do {
            // Decode responsedata to Expactred Model Type
            let mealsParseData = try JSONDecoder().decode(MealsDataModel.self, from: responseData!)
            
            if let arryMeals = mealsParseData.meals {
                mealsList = arryMeals.sorted { $0.title ?? "" < $1.title ?? ""}
            } else {
                self.responseError = "Something went wrong!!!"
                print("Something went wrong!!!")
            }
        } catch {
            responseError = "Something went wrong!!!"
        }
    }
}
