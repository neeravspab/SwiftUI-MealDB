//
//  HTTPRequest.swift
//  Fetch
//
//  Created by niravkumar patel on 7/26/23.
//

import Foundation

//Type Alias For complition Hendler
typealias Handler<T> = (Result<T, Error>) -> Void

// This is escaping for viewmodel to infrom view to update data.
enum ComplitionResult {
    case dataloaded
    case datafail
}

// HTTTPRequest Components
protocol RequestComponents {
    var path: String { get }
    var baseURL: String { get }
    var url: URL? { get }
    var method: HTTPRequestMethod { get }
    var params: String { get }
}

// HTTTPURL Request Components

struct URLRequestComponents {
    var components: RequestComponents
}

protocol HTTPRequestProtocal {
    func performRequest(urlRequestComponents: URLRequestComponents,
                        completion: ((Result<Data,Error>) -> Void)?)
}

// HTTP Request Class
class HTTPRequest:HTTPRequestProtocal {
    
    // API Request
    /// -Parameter
    /// argument 1:  urlrequestcomponent which includes url path name and parameter if required
    
    func performRequest(urlRequestComponents: URLRequestComponents, completion: ((Result<Data, Error>) -> Void)?) {
        if Reachability.isConnectedToNetwork() {
            let request = configureHTTPRequest(urlRequestComponents)
            performUrlrequest(request, completion)
        } else {
            completion?(.failure(HttpError.serverSideError))
        }
    }
    
    // PonfigureHTTPRequest
    private func configureHTTPRequest(_ urlRequestComponents: URLRequestComponents) -> URLRequest? {
        guard let url = urlRequestComponents.components.url else { return nil }
        
        var urlrequest = URLRequest(url: url)
        urlrequest.httpMethod = urlRequestComponents.components.method.rawValue
        
        return urlrequest
    }
    
    // PerformUrlrequest With URLSession
    private func performUrlrequest(_ request: URLRequest?, _ completion: ((Result<Data, Error>) -> Void)?) {
        guard let request = request else {
            completion?(.failure(HttpError.badRequest))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.handleResponseData(data: data, response: response, error: error, completion: completion)
            }
        }.resume()
    }
    
    // HandleResponseData
    private func handleResponseData(data: Data?, response: URLResponse?,
                                    error: Error?,
                                    completion: ((Result<Data, Error>) -> Void)?) {
        guard let unwrappedResponse = response as? HTTPURLResponse, let unwrappedData = data else {
            if let unwrappedError = error {
                completion?(.failure(unwrappedError))
            } else {
                completion?(.failure(HttpError.InvalidRequest))
            }
            return
        }
        
        if let error = self.getHTTPNetworkError(for: unwrappedResponse) {
            print(error.localizedDescription)
            completion?(.failure(error))
        } else {
            completion?(.success(unwrappedData))
        }
    }
    
    //  Function to Check errror by network Response status code
    
    private func getHTTPNetworkError(for response: HTTPURLResponse) -> HttpError? {
        switch response.statusCode {
        case 200...299: return nil
        case 401: return HttpError.authenticationError
        case 400...499: return HttpError.badRequest
        case 500...599: return HttpError.serverSideError
        default: return HttpError.failed
        }
    }
}

