//
//  APIs.swift
//  Fetch
//
//  Created by niravkumar patel on 7/26/23.
//

import Foundation

enum API {
    case meals(param:String)
    case mealsDetail(param:String)
}

extension API: RequestComponents {
    
    var params: String {
        switch self {
        case .meals(let type): return type
        case .mealsDetail(let id): return id
        }
    }
    
    var path: String {
        switch self {
        case .meals: return "filter.php?c="
        case .mealsDetail: return "lookup.php?i="
        }
    }
    
    var baseURL: String {
        Constants.baseURL
    }
    
    var url: URL? {
        URL(string: "\(baseURL)\(path)\(params)")
    }
    
    var method: HTTPRequestMethod {
        switch self {
        case .meals, .mealsDetail : return .get
        
        }
    }
}

