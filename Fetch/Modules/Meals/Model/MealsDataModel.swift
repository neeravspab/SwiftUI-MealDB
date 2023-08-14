//
//  MealsDataModel.swift
//  Fetch
//
//  Created by niravkumar patel on 7/26/23.
//

import Foundation

struct MealsDataModel: Codable {
    let meals: [MealsList]?
    
    enum CodingKeys: String, CodingKey {
        case meals = "meals"
    }
}

struct MealsList: Codable,Identifiable,Equatable {
    let title: String?
    let image: String?
    let id: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "strMeal"
        case image = "strMealThumb"
        case id = "idMeal"
    }
}
