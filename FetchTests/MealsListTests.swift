//
//  MealsListTests.swift
//  FetchTests
//
//  Created by niravkumar patel on 7/27/23.
//

import XCTest
import Combine
@testable import Fetch

final class MealsListTests: XCTestCase {
       
    // Success Case
    func testMealsList_Successfull() {
        
        let aspectedList = [MealsList(title: "Apam balik", image: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", id: "53049"),
                            MealsList(title: "Apple & Blackberry Crumble", image: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg", id: "52893")]
        let mockService = MockMealService()
        let cancellable: AnyCancellable?
        
        let data = mockService.loadJson(fileName: "MealsListResponse")
        mockService.result = .success(data!)
        
        // system under test
        let sut = MealsListViewModel(request: mockService)
        let expectation = XCTestExpectation(description: "Feching Meals")
        
        cancellable = sut.$mealsList
            .dropFirst()
            .sink(receiveValue: { mealList in
                XCTAssertEqual(mealList.count, 2)
                XCTAssertEqual(mealList, aspectedList)
                XCTAssertNil(sut.responseError)
                expectation.fulfill()
            })
        
        sut.fetchMealsListWith("Dessert")
        wait(for: [expectation], timeout: 1)
    }
    
    // Failure Case
    func test_MealsList_Failure() {
        
        let mockService = MockMealService()
        mockService.result = .failure(MockError.defaultError)

        let sut = MealsListViewModel(request: mockService)
        sut.fetchMealsListWith("")
        XCTAssertEqual(sut.responseError, "category not found")
        XCTAssertTrue(sut.mealsList.isEmpty)
        XCTAssertNotNil(sut.responseError)
    }
}
