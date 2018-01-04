//
//  DSDoctorsViewController.swift
//  DoctorSearch
//
//  Created by Mohamed Magdy on 04.01.18.
//  Copyright © 2018 Mohamed. All rights reserved.
//

import UIKit
import CoreLocation
import MBProgressHUD

class DSDoctorsViewController: DSBaseViewController {
    
    //MARK: - Properties
    internal let doctorStore          : DSDoctorSearchStore = DSDoctorSearchStore()
    internal let locationManager      : CLLocationManager = CLLocationManager()

    internal var currentLocation      : CLLocationCoordinate2D? {
        didSet {
            getDoctorsForCurrentLocationWith(searchText: searchText)
        }
    }
    
    internal var doctorViewModelArray          : [DSDoctorViewModel]? {
        didSet {
            tableView.reloadData()
        }
    }
    private  var doctorViewModelArrayContainer : [DSDoctorViewModel]? {
        set {
            if doctorViewModelArray == nil {
                doctorViewModelArray = newValue
            }
            else {
                if let value = newValue {
                    doctorViewModelArray! += value
                }
            }
        }
        get {
            return doctorViewModelArray
        }

    }
    internal var searchController    : UISearchController = UISearchController(searchResultsController: nil)
    internal var searchText          : String? {
        didSet {
            doctorStore.lastKey = nil
            doctorViewModelArray = nil
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
            MBProgressHUD.showAdded(to: view, animated: true)
            doctorStore.getDoctorsListForLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude, searchText: searchText, success: { [weak self] (modelArray) in
                guard let strongSelf = self else { return }
                MBProgressHUD.hide(for: strongSelf.view, animated: true)
                strongSelf.doctorViewModelArrayContainer = modelArray as? [DSDoctorViewModel]
            }) { [weak self](error) in
                guard let strongSelf = self else { return }
                MBProgressHUD.hide(for: strongSelf.view, animated: true)
                strongSelf.handleError(error: error)
            }
        }
        
    }
    internal func requestNextPage() {
        getDoctorsForCurrentLocationWith(searchText: searchText)
    }
}
