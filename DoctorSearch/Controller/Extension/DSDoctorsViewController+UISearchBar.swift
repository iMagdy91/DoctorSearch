//
//  DSDoctorsViewController+UISearchBar.swift
//  DoctorSearch
//
//  Created by Mohamed Magdy on 04.01.18.
//  Copyright © 2018 Mohamed. All rights reserved.
//

import UIKit

extension DSDoctorsViewController: UISearchBarDelegate, UISearchControllerDelegate {
    
    // MARK: - UISearchBarDelegate Methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchController.searchBar.text != "" {
            searchText = searchController.searchBar.text
        }
    }
    
    // MARK: - UISearchControllerDelegate Methods
    func didDismissSearchController(_ searchController: UISearchController) {
        searchText = nil
    }
}
