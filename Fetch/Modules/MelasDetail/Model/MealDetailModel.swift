//
//  MealDetailModel.swift
//  Fetch
//
//  Created by niravkumar patel on 7/26/23.
//

import Foundation
import SwiftUI

struct MealDetailModel:Codable {
    let meals: [MealDetailDataModel]?
}

struct MealDetailDataModel:Codable {

    let idMeal: String?
    let strMeal: String?
    var strDrinkAlternate:String?
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strMealThumb: String?
    let strTags: String?
    let strYoutube: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    let strSource: String?
    let strImageSource:String?
    let strCreativeCommonsConfirmed:String?
    let dateModified:String?
}

struct Meal: Codable {
    let idMeal: String
    let strMeal: String
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: String
    let strYoutube: String
    let strSource: String
    
    private enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strCategory, strArea, strInstructions, strMealThumb, strYoutube, strSource
    }

    // Ingredients and measurements dictionary
    var ingredientsAndMeasurements: [String: String] {
        var result: [String: String] = [:]

        let container = try? decoder!.container(keyedBy: CodingKeys.self)
        container?.allKeys.forEach { key in
            if key.stringValue.starts(with: "strIngredient") {
                if let ingredient = try? container?.decode(String.self, forKey: key), !ingredient.isEmpty {
                    let index = key.stringValue.dropFirst("strIngredient".count)
                    let measurementKey = CodingKeys(stringValue: "strMeasure\(index)")
                    if let measurement = try? container?.decode(String.self, forKey: measurementKey!), !measurement.isEmpty {
                        result[ingredient] = measurement
                    }
                }
            }
        }

        return result
    }

    private var decoder: Decoder? // Private variable to hold the decoder instance during decoding

    init(from decoder: Decoder) throws {
        self.decoder = decoder // Save the decoder instance for later use
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strCategory = try container.decode(String.self, forKey: .strCategory)
        strArea = try container.decode(String.self, forKey: .strArea)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        strYoutube = try container.decode(String.self, forKey: .strYoutube)
        strSource = try container.decode(String.self, forKey: .strSource)
    }
}


//struct MealsResponse: Codable {
//    let meals: [Meal]
//}
