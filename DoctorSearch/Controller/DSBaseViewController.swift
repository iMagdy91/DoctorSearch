//
//  DSBaseViewController.swift
//  DoctorSearch
//
//  Created by Mohamed Magdy on 04.01.18.
//  Copyright © 2018 Mohamed. All rights reserved.
//

import UIKit

class DSBaseViewController: UIViewController {

    // MARK: - Utils
    func handleError(error: Error) {
        showMessage(message: error.localizedDescription)
    }
    
    private func showMessage(message: String) {
        let alertController = UIAlertController.init(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
