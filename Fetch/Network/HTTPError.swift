//
//  HTTPError.swift
//  Fetch
//
//  Created by niravkumar patel on 7/26/23.
//

import Foundation

enum HttpError: Error {
    case badRequest
    case InvalidRequest
    case authenticationError
    case noData
    case serverSideError
    case failed
}
