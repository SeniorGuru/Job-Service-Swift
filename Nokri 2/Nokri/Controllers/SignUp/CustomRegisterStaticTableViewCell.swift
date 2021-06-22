//
//  CustomRegisterStaticTableViewCell.swift
//  Nokri
//
//  Created by apple on 2/20/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit

class CustomRegisterStaticTableViewCell: UITableViewCell {

    @IBOutlet weak var btnCheckBox: UIButton!
    @IBOutlet weak var lblTermsText: UILabel!
    @IBOutlet weak var imageViewCheckBox: UIImageView!
    @IBOutlet weak var btnSignUp: UIButton!
    
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnCheckBox.layer.borderWidth = 2.0
        btnCheckBox.layer.borderColor = UIColor.lightGray.cgColor
        btnSignUp.setTitleColor(UIColor.white, for: .normal)
        btnSignUp.backgroundColor = UIColor(hex: appColorNew!)
        btnSignUp.layer.cornerRadius = 22
        imageViewCheckBox.isHidden = true
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnCheckBoxClicked(_ sender: UIButton) {
           if imageViewCheckBox.isHidden == true{
               imageViewCheckBox.isHidden = false
           }else{
               imageViewCheckBox.isHidden = true
           }
       }
    
}
