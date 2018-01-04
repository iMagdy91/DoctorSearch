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
    
    //MARK: - Properties
    var cache                               :NSCache<AnyObject, AnyObject> = NSCache()
    
    //MARK: - Outlets
    @IBOutlet weak var doctorImageView      : UIImageView!
    @IBOutlet weak var doctorNameLabel      : UILabel!
    @IBOutlet weak var doctorAddressLabel   : UILabel!
    
    // MARK: - Cell Customization
    func customizeCellWithModel(_ doctor: DSDoctorViewModel?,
                                doctorStore: DSDoctorSearchStore,
                                indexPath: IndexPath) {
        doctorNameLabel.text = doctor?.name
        doctorAddressLabel.text = doctor?.address
        tag = indexPath.row
        doctorImageView.image = #imageLiteral(resourceName: "Placeholder")
        if let photoID = doctor?.photoID {
            if (cache.object(forKey: photoID as AnyObject) != nil){
                doctorImageView.image = self.cache.object(forKey: photoID as AnyObject) as? UIImage
            }
            else {
                doctorStore.getPhotoWithID(photoID, andPhotoDataClosure: {[weak self] (data) in
                    guard let strongSelf = self else { return }
                    let image = UIImage(data: data)
                    if let img = image {
                        DispatchQueue.main.async {
                            if strongSelf.tag == indexPath.row {
                                strongSelf.cache.setObject(img, forKey: photoID as AnyObject)
                                strongSelf.doctorImageView.image = img
                            }
                        }
                    }
                })
            }
        }
    }
}
