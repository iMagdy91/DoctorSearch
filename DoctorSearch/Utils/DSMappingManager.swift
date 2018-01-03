//
//  DSMappingManager.swift
//  DoctorSearch
//
//  Created by Mohamed Magdy on 03.01.18.
//  Copyright © 2018 Mohamed. All rights reserved.
//

import Foundation

class DSMappingManager {
    
    
    /**
     Map DSDoctorSearchDTO to DSDoctorViewModel for the UI usage.
     
     - Parameter doctorDTO: DSDoctorSearchDTO to be mapped.
     - Returns : mapped DSDoctorViewModel array.
     .
     */
    class func mapDoctorDTOToDoctorViewModel(_ doctorDTO: DSDoctorSearchDTO) -> [DSDoctorViewModel] {
        var doctorsViewModel = [DSDoctorViewModel]()
        if let doctorsArray = doctorDTO.doctors {
            doctorsViewModel = doctorsArray.map { (doctor) -> DSDoctorViewModel in
                return DSDoctorViewModel(doctorID: doctor.id, name: doctor.name, phoneNumber: doctor.phoneNumber, address: doctor.address, photoID: doctor.photoID)
            }
        }
        
        return doctorsViewModel
    }
}
