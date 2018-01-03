//
//  AuthenticationObject.swift
//  DoctorSearch
//
//  Created by Mohamed Magdy on 03.01.18.
//  Copyright © 2018 Mohamed. All rights reserved.
//

import Foundation
import ObjectMapper

// DTO Class to parse content of Authentication API into.
class DSAuthenticationObject: DSBaseMappable {
    
    // MARK: - Properties
    private(set) var accessToken        : String?
    private(set) var tokenType          : String?
    private(set) var refreshToken       : String?
    private(set) var expiresIn          : Int?
    private(set) var scope              : String?
    private(set) var jti                : String?
    
    
    /**
     Mapping from API
     */
    override func mapping(map: Map) {
        accessToken     <- map["access_token"]
        tokenType       <- map["token_type"]
        refreshToken    <- map["refresh_token"]
        expiresIn       <- map["expires_in"]
        scope           <- map["scope"]
        jti             <- map["jti"]
    }
}
