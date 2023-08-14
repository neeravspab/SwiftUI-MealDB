//
//  MealDetailTests.swift
//  FetchTests
//
//  Created by niravkumar patel on 7/27/23.
//

import XCTest
import Combine
@testable import Fetch

final class MealDetailTests: XCTestCase {
       
    // Success Case
    func testMealsDetailList_Successfull() {
        
        let aspectedList = [MealDetailDataModel(idMeal: "53049", strMeal: "Apam balik", strDrinkAlternate: nil,strCategory: "Dessert", strArea: "Malaysian", strInstructions: "Mix milk, oil and egg together. Sift flour, baking powder and salt into the mixture. Stir well until all ingredients are combined evenly.\r\n\r\nSpread some batter onto the pan. Spread a thin layer of batter to the side of the pan. Cover the pan for 30-60 seconds until small air bubbles appear.\r\n\r\nAdd butter, cream corn, crushed peanuts and sugar onto the pancake. Fold the pancake into half once the bottom surface is browned.\r\n\r\nCut into wedges and best eaten when it is warm.", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", strTags: nil, strYoutube: "https://www.youtube.com/watch?v=6R8ffRRJcrg", strIngredient1: "Milk", strIngredient2: "Oil", strIngredient3: "Eggs", strIngredient4: "Flour", strIngredient5: "Baking Powder", strIngredient6: "Salt", strIngredient7: "Unsalted Butter", strIngredient8: "Sugar", strIngredient9: "Peanut Butter", strIngredient10: "", strIngredient11: "", strIngredient12: "", strIngredient13: "", strIngredient14: "", strIngredient15: "", strIngredient16: "", strIngredient17: "", strIngredient18: "", strIngredient19: "", strIngredient20: "", strMeasure1: "200ml", strMeasure2: "60ml", strMeasure3: "2", strMeasure4: "1600g", strMeasure5: "3 tsp", strMeasure6: "1/2 tsp", strMeasure7: "25g", strMeasure8: "45g", strMeasure9: "3 tbs", strMeasure10: "", strMeasure11: "", strMeasure12: "", strMeasure13: "", strMeasure14: "", strMeasure15: "", strMeasure16: "", strMeasure17: "", strMeasure18: "", strMeasure19: "", strMeasure20: "", strSource: "", strImageSource: "", strCreativeCommonsConfirmed: "", dateModified: "")]
        
        let mockService = MockMealService()
        let cancellable: AnyCancellable?
        
        let data = mockService.loadJson(fileName: "MelasDetailResponse")
        mockService.result = .success(data!)
        
        // system under test
        let sut = MealDetailViewModel(request: mockService)
        
        let expectation = XCTestExpectation(description: "Feching Meals")
        
        cancellable = sut.$mealsDetail
            .dropFirst()
            .sink(receiveValue: { mealdetail in
                XCTAssertEqual(mealdetail?.idMeal, aspectedList[0].idMeal)
                XCTAssertNil(sut.responseError)
                expectation.fulfill()
            })
        
        sut.fetchMealDetailWith(mealID: "53049")
        wait(for: [expectation], timeout: 2)
    }
    
    // Failure Case
    func testMealsList_Failure() {
        
        let mockService = MockMealService()
        _ = mockService.loadJson(fileName: "")
        mockService.result = .failure(MockError.defaultError)

        let sut = MealDetailViewModel(request: mockService)
        sut.fetchMealDetailWith(mealID: "")
        
        XCTAssertEqual(sut.responseError, "meal id not found")
        XCTAssertEqual(sut.mealsDetail?.idMeal, nil)
    }
}
