//
//  DSBaseStore.swift
//  DoctorSearch
//
//  Created by Mohamed Magdy on 03.01.18.
//  Copyright © 2018 Mohamed. All rights reserved.
//

import Foundation

protocol DSBaseStore {
    typealias ErrorClosure      = (Error) -> Void
    typealias ViewModelClosure  = ([DSBaseViewModel]?) -> Void
    typealias BaseDTOClosure    = (DSBaseMappable?) -> Void
    typealias PhotoClosure      = (Data) -> Void

}
