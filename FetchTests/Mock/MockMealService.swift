//
//  MockMealService.swift
//  FetchTests
//
//  Created by niravkumar patel on 7/27/23.
//

import Foundation
@testable import Fetch

class MockMealService: HTTPRequestProtocal {
    
    var result: Result<Data,Error>!
    
    func performRequest(urlRequestComponents: URLRequestComponents, completion: ((Result<Data, Error>) -> Void)?) {
        completion?(result)
    }
    
    // Load Json file from project
    func loadJson(fileName: String) -> Data? {
        
        guard let url = Bundle(for: MockMealService.self).url(forResource: fileName, withExtension: "json") else {
            return nil
        }
    
        guard let jsondata = try? Data(contentsOf: url) else { return nil }
        return jsondata
    }
}

//MARK: Mock Error
enum MockError: Error {
    case defaultError
}
