//
//  DSDoctorSearchDTO.swift
//  DoctorSearch
//
//  Created by Mohamed Magdy on 03.01.18.
//  Copyright © 2018 Mohamed. All rights reserved.
//

import Foundation
import ObjectMapper

// DTO Class to parse content of Doctor Search API.
class DSDoctorSearchDTO: DSBaseMappable {
    
    // MARK: - Properties
    private(set) var doctors              : [DSDoctor]?
    private(set) var lastKey              : String?
    
    
    /**
     Mapping from API
     */
    override func mapping(map: Map) {
        doctors           <- map["doctors"]
        lastKey           <- map["lastKey"]
    }
}

class DSDoctor: DSBaseMappable {
    // MARK: - Properties
    private(set) var address              : String?
    private(set) var email                : String?
    private(set) var highlighted          : Bool?
    private(set) var id                   : String?
    private(set) var lat                  : Double?
    private(set) var lng                  : Double?
    private(set) var name                 : String?
    private(set) var openingHours         : [String?]?
    private(set) var phoneNumber          : String?
    private(set) var photoID              : String?
    private(set) var rating               : Double?
    private(set) var reviewCount          : Int?
    private(set) var source               : String?
    private(set) var specialityIDs        : [String?]?
    private(set) var website              : String?
    
    /**
     Mapping from API
     */
    override func mapping(map: Map) {
        address          <- map["address"]
        email            <- map["email"]
        highlighted      <- map["highlighted"]
        id               <- map["id"]
        lat              <- map["lat"]
        lng              <- map["lng"]
        name             <- map["name"]
        openingHours     <- map["openingHours"]
        phoneNumber      <- map["phoneNumber"]
        photoID          <- map["photoId"]
        rating           <- map["rating"]
        reviewCount      <- map["reviewCount"]
        source           <- map["source"]
        specialityIDs    <- map["specialityIds"]
        website          <- map["website"]
    }
}
