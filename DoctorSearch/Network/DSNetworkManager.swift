//
//  DSNetworkManager.swift
//  DoctorSearch
//
//  Created by Mohamed Magdy on 03.01.18.
//  Copyright © 2018 Mohamed. All rights reserved.
//

import Foundation
import Alamofire

typealias NetworkSuccessClosure     = (Any?) -> Void
typealias NetworkErrorClosure       = (Error) -> Void

class DSNetworkManager {
    
    /**
     Requests data from API and get the response back.
     
     - Parameter baseURL: Base URL for the API.. Default value is https://uvita.eu
     - Parameter path: API path.
     - Parameter requestMethod: request method .GET .POST etc..
     - Parameter parameters: request parameters.
     - Parameter headers: request headers.
     - Parameter success: response success block.
     - Parameter failure: response failure block.
     */
    
    class func performRequestWithPath(baseURL: String = Network.uvitaBaseURL,
                                      path: String?,
                                      requestMethod: Alamofire.HTTPMethod,
                                      parameters: [String : Any]?,
                                      headers: [String : String]?,
                                      success: @escaping NetworkSuccessClosure,
                                      failure: @escaping NetworkErrorClosure) {
        
        let url = (path != nil) ? baseURL + path! : baseURL
        Alamofire.request(url, method: requestMethod, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                    
                case .success(_):
                    success(response.result.value)
                case .failure(let error):
                    failure(error)
                }
        }
    }
}

