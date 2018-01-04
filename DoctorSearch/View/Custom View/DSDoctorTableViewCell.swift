//
//  DSDoctorTableViewCell.swift
//  DoctorSearch
//
//  Created by Mohamed Magdy on 04.01.18.
//  Copyright © 2018 Mohamed. All rights reserved.
//

import UIKit
import Kingfisher

typealias ImageDownloadCompletion = () -> Void

class DSDoctorTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var doctorImageView: UIImageView!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var doctorAddressLabel: UILabel!
    
    // MARK: - Cell Customization
    func customizeCellWithModel(doctor: DSDoctorViewModel?, completion: @escaping ImageDownloadCompletion) {
        doctorNameLabel.text = doctor?.name
        doctorAddressLabel.text = doctor?.address
        
        if let urlString = doctor?.photoID {
            let url = URL(string: urlString)
            doctorImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "Placeholder"), options: nil, progressBlock: nil, completionHandler: {[weak self] (image, error, cacheType, url) in
                self?.doctorImageView.sizeToFit()
                if cacheType == .none || cacheType == .disk {
                    completion()
                }
            })
        }
    }
}
