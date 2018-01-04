//
//  DSDoctorsViewController+CoreLocation.swift
//  DoctorSearch
//
//  Created by Mohamed Magdy on 04.01.18.
//  Copyright © 2018 Mohamed. All rights reserved.
//

import UIKit
import CoreLocation

extension DSDoctorsViewController: CLLocationManagerDelegate {
    
    //MARK: - Utility Methods
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    
    //MARK: - CLLocationManagerDelegate methods
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            manager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        currentLocation = manager.location?.coordinate
        manager.stopUpdatingLocation()
    }
}
