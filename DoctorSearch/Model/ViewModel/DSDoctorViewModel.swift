//
//  DSDoctorViewModel.swift
//  DoctorSearch
//
//  Created by Mohamed Magdy on 03.01.18.
//  Copyright © 2018 Mohamed. All rights reserved.
//

import Foundation

//UI model
class DSDoctorViewModel: DSBaseViewModel {
    
    //MARK: - Properties
    private(set) var doctorID        : String?
    private(set) var name            : String?
    private(set) var phoneNumber     : String?
    private(set) var address         : String?
    private(set) var photoID         : String?
    
    
    //MARK: - Init
    required init(doctorID: String?,
                  name: String?,
                  phoneNumber: String?,
                  address: String?,
                  photoID: String?) {
        self.doctorID       = doctorID
        self.name           = name
        self.phoneNumber    = phoneNumber
        self.address        = address
        self.photoID        = photoID
    }
    
}
