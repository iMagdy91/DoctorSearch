//
//  DSDoctorsViewController+UITableView.swift
//  DoctorSearch
//
//  Created by Mohamed Magdy on 04.01.18.
//  Copyright © 2018 Mohamed. All rights reserved.
//

import UIKit

extension DSDoctorsViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - UITableViewDataSource Methods
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return doctorViewModelArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return constructCellForTableView(tableView:tableView, atIndexPath:indexPath)
    }
    
    
    
    //MARK: - UITableViewDelegate Methods
    func tableView(_ tableView: UITableView,
                   estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewConstants.estimatedRowHeight
    }
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        let modelArray = doctorViewModelArray
        
        if let doctors = modelArray {
            if indexPath.row == doctors.count - 1 {
                requestNextPage()
            }
        }

    }
    
    // MARK: - Cell Construction Methods
    func constructCellForTableView(tableView: UITableView,
                                   atIndexPath indexPath: IndexPath) -> DSDoctorTableViewCell {
        let cell: DSDoctorTableViewCell?  = tableView.dequeueReusableCell(withIdentifier: UITableViewCellIdentifier.doctorCellIdentifier) as? DSDoctorTableViewCell
        
        let doctorModel = doctorViewModelArray?[indexPath.row]
        
        cell?.customizeCellWithModel(doctorModel, doctorStore: doctorStore, indexPath: indexPath)

        return cell!
    }
}
