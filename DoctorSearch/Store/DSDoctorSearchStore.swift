//
//  DSDoctorSearch.swift
//  DoctorSearch
//
//  Created by Mohamed Magdy on 03.01.18.
//  Copyright © 2018 Mohamed. All rights reserved.
//

import Foundation
import ObjectMapper

//TODO: Static only for this challenge!
fileprivate let username                : String = "ioschallenge@uvita.eu"
fileprivate let password                : String = "shouldnotbetoohard"
fileprivate let tokenRetryLimit         : Int    = 10

class DSDoctorSearchStore: DSBaseStore {
    
    
    //MARK: - Properties
    private  var accessToken             : DSAuthenticationObject?
    internal var lastKey                 : String?
    private  let authenticationManager   : DSAuthenticationManager = DSAuthenticationManager()
    private  var retryCount              : Int = 0
    
    //MARK: - Methods
    
    /**
     Requests and filters Doctors list near you.
     
     - Parameter latitude: latitude of the current user.
     - Parameter longitude: longitude of the current user.
     - Parameter searchText: Optional search text for filtering.
     - Parameter success: Callback with the result array.
     - Parameter failure: Error callback.
     
     */
    
    func getDoctorsListForLocation(latitude: Double,
                                   longitude: Double,
                                   searchText: String?,
                                   success: @escaping ViewModelClosure,
                                   failure: @escaping ErrorClosure){
        if let token = accessToken?.accessToken {
            let headersDictionary = [DoctorSearchHeaders.acceptHeaderKey : DoctorSearchHeaders.acceptHeaderValue,
                                     DoctorSearchHeaders.authorizationHeaderKey : DoctorSearchHeaders.authorizationHeaderValue + token]
            
            var parametersDictionary: [String : Any] = [DoctorSearchParameters.latitudeKey : latitude,
                                        DoctorSearchParameters.longitudeKey : longitude]
            
            if let lastKeyString = lastKey {
                parametersDictionary[DoctorSearchParameters.lastKeyKey] = lastKeyString
            }
            if let searchString = searchText {
                parametersDictionary[DoctorSearchParameters.searchKey] = searchString
            }
            
            DSNetworkManager.performRequestWithPath(path: Network.doctorSearchPath, requestMethod: .get, parameters: parametersDictionary, headers: headersDictionary, success: { [weak self](response) in
                guard let strongSelf = self else { return }
                let doctorSearchModel: DSDoctorSearchDTO? = Mapper<DSDoctorSearchDTO>().map(JSONObject: response)
                if let doctorsModel = doctorSearchModel {
                    //Mapping response to view model
                    strongSelf.lastKey = doctorsModel.lastKey
                    strongSelf.retryCount = 0 //Reseting the retry count after a successful response
                    let doctorsViewModel: [DSDoctorViewModel] = DSMappingManager.mapDoctorDTOToDoctorViewModel(doctorsModel)
                    success(doctorsViewModel)
                }
                else {
                    //Request a refresh token as the token might be expired
                    strongSelf.authenticationManager.refreshTokenWith(token: token, tokenClosure: {[weak self] (tokenObject) in
                        guard let strongSelf = self else { return }
                        strongSelf.accessToken = tokenObject as? DSAuthenticationObject
                        strongSelf.retryCount += 1
                        if strongSelf.retryCount < tokenRetryLimit {
                            strongSelf.getDoctorsListForLocation(latitude: latitude, longitude: longitude, searchText: searchText, success: success, failure: failure)
                        }
                    }, failure: failure)
                }
            }, failure: failure)
            
        }
        else {
            //Request a new token when there's no token object available
            authenticationManager.getTokenWithUsername(username, password: password, tokenClosure: { [weak self] (tokenObject) in
                guard let strongSelf = self else { return }
                strongSelf.accessToken = tokenObject as? DSAuthenticationObject
                if let _ = strongSelf.accessToken?.accessToken {
                    strongSelf.getDoctorsListForLocation(latitude: latitude, longitude: longitude, searchText: searchText, success: success, failure: failure)
                }
            }, failure: failure)
        }
    }
    
    
}
