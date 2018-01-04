//
//  DSDoctorsViewController.swift
//  DoctorSearch
//
//  Created by Mohamed Magdy on 04.01.18.
//  Copyright © 2018 Mohamed. All rights reserved.
//

import UIKit
import CoreLocation

class DSDoctorsViewController: DSBaseViewController {
    
    //MARK: - Properties
    private  let doctorStore          : DSDoctorSearchStore = DSDoctorSearchStore()
    internal let locationManager      : CLLocationManager = CLLocationManager()

    internal var currentLocation      : CLLocationCoordinate2D? {
        didSet {
            getDoctorsForCurrentLocationWith(searchText: searchText)
        }
    }
    internal var doctorViewModelArray : [DSDoctorViewModel]? {
        didSet {
            tableView.reloadData()
        }
    }
    internal var searchController    : UISearchController = UISearchController(searchResultsController: nil)
    internal var searchText          : String? {
        didSet {
            doctorStore.lastKey = nil
            getDoctorsForCurrentLocationWith(searchText: searchText)
        }
    }
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLocationManager()
    }
    //MARK:- Private Methods
    private func setupView() {
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = UITableViewConstants.estimatedRowHeight
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.delegate = self
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    private func getDoctorsForCurrentLocationWith(searchText: String?) {
        if let currentLocation = self.currentLocation {
            doctorStore.getDoctorsListForLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude, searchText: searchText, success: { [weak self] (modelArray) in
                self?.doctorViewModelArray = modelArray as? [DSDoctorViewModel]
            }) { [weak self](error) in
                self?.handleError(error: error)
            }
        }
        
    }
    internal func requestNextPage() {
        getDoctorsForCurrentLocationWith(searchText: searchText)
    }
}
