//
//  EmployerSearchedTableViewCell.swift
//  Nokri
//
//  Created by Furqan Nadeem on 01/06/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit

class EmployerSearchedTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageViewCanSearched: UIImageView!
  
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblSubName: UILabel!
    
    @IBOutlet weak var btnClickedCandidate: UIButton!
    
    @IBOutlet weak var viewBehindCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nokri_shadow()
    }
    
    func nokri_shadow(){
    
    viewBehindCell.layer.borderColor = UIColor.gray.cgColor
    viewBehindCell.layer.cornerRadius = 0
    viewBehindCell.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
    viewBehindCell.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    viewBehindCell.layer.shadowOpacity = 0.8
    viewBehindCell.layer.shadowRadius = 2
}

}
