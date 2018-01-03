//
//  DSAuthenticationStore.swift
//  DoctorSearch
//
//  Created by Mohamed Magdy on 03.01.18.
//  Copyright © 2018 Mohamed. All rights reserved.
//

import Foundation
import ObjectMapper

class DSAuthenticationManager: DSBaseStore {
    
    /**
    Default headers for Authentication API
    */
    let headersDictionary = [AuthenticationHeaders.acceptHeaderKey : AuthenticationHeaders.acceptHeaderValue,
                             AuthenticationHeaders.authorizationHeaderKey : AuthenticationHeaders.authorizationHeaderValue,
                             AuthenticationHeaders.contentTypeHeaderKey : AuthenticationHeaders.contentTypeHeaderValue]

    
    /**
     Requests a new access token for Uvita APIs.
     
     - Parameter username: username for the token.
     - Parameter password: password for the token.
     - Parameter tokenClosure: Callback with the Token object.
     - Parameter failure: Error callback.

     */
    func getTokenWithUsername(_ username: String,
                              password: String,
                              tokenClosure: @escaping BaseDTOClosure,
                              failure: @escaping ErrorClosure){
        let parametersDictionary = [AuthenticationParameters.grantTypeKey : AuthenticationParameters.passwordKey,
                                    AuthenticationParameters.usernameKey : username,
                                    AuthenticationParameters.passwordKey : password]
        performAuthenticationRequestWith(parameters: parametersDictionary, tokenClosure: tokenClosure, failure: failure)
      
    }
    
    /**
     Refreshes an expired token for Uvita APIs.
     
     - Parameter token: Expired acess token.
     - Parameter tokenClosure: Callback with the Token object.
     - Parameter failure: Error callback.
     
     */
    func refreshTokenWith(token: String,
                          tokenClosure: @escaping BaseDTOClosure,
                          failure: @escaping ErrorClosure){
        let parametersDictonary = [AuthenticationParameters.refreshTokenKey : token,
                                   AuthenticationParameters.grantTypeKey : AuthenticationParameters.grantTypeRefreshValue]
        performAuthenticationRequestWith(parameters: parametersDictonary, tokenClosure: tokenClosure, failure: failure)
        
    }
    
    
    
    private func performAuthenticationRequestWith(parameters: [String:String],
                                                  tokenClosure: @escaping BaseDTOClosure,
                                                  failure: @escaping ErrorClosure){
        DSNetworkManager.performRequestWithPath(path: Network.authenticationPath, requestMethod: .post, parameters: parameters, headers: headersDictionary, success: { (response) in
            let authenticationObject: DSAuthenticationObject? = Mapper<DSAuthenticationObject>().map(JSONObject: response)
            tokenClosure(authenticationObject)
        }, failure: failure)
    }
}
