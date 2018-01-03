//
//  Constants.swift
//  DoctorSearch
//
//  Created by Mohamed Magdy on 03.01.18.
//  Copyright © 2018 Mohamed. All rights reserved.
//

import Foundation

struct Network {
    //DoctorSearch APIs
    static let uvitaBaseURL                = "https://uvita.eu"
    static let authenticationPath          = "/oauth/token"
    static let doctorSearchPath            = "/api/users/me/doctors" //UserID is "me" for now till implementation of the login service
}

struct AuthenticationHeaders {
    static let authorizationHeaderKey      = "Authorization"
    static let contentTypeHeaderKey        = "Content-Type"
    static let acceptHeaderKey             = "Accept"
    
    static let authorizationHeaderValue    = "Basic aXBob25lOmlwaG9uZXdpbGxub3RiZXRoZXJlYW55bW9yZQ==" //Static for now as the current credintials encoding is unauthorized
    static let contentTypeHeaderValue      = "application/x-www-form-urlencoded"
    static let acceptHeaderValue           = "application/json"
}

struct AuthenticationParameters {
    static let grantTypeKey                = "grant_type"
    static let usernameKey                 = "username"
    static let passwordKey                 = "password"
    static let refreshTokenKey             = "refresh_token"

    
    static let grantTypeRefreshValue       = "refresh_token"
}
