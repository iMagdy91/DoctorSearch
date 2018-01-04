//
//  DSDoctorsViewController.swift
//  DoctorSearch
//
//  Created by Mohamed Magdy on 04.01.18.
//  Copyright © 2018 Mohamed. All rights reserved.
//

import UIKit

class DSDoctorsViewController: DSBaseViewController {
    
    //MARK: - Properties
    private let doctorStore: DSDoctorSearchStore = DSDoctorSearchStore()
    internal var doctorViewModelArray: [DSDoctorViewModel]? {
        didSet {
            tableView.reloadData()
        }
    }
    internal var searchText: String? {
        didSet {
            getDoctorsForCurrentLocationWith(searchText: searchText)
        }
    }
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func getDoctorsForCurrentLocationWith(searchText: String?) {
        doctorStore.getDoctorsListForLocation(latitude: 51, longitude: 1, searchText: searchText, success: { [weak self] (modelArray) in
            self?.doctorViewModelArray = modelArray as? [DSDoctorViewModel]
        }) { [weak self](error) in
            self?.handleError(error: error)
        }
    }
}
