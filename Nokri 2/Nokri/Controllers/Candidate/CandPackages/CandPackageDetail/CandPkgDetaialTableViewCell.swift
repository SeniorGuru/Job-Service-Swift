//
//  CandPkgDetaialTableViewCell.swift
//  Nokri
//
//  Created by apple on 4/7/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit

class CandPkgDetaialTableViewCell: UITableViewCell {

    @IBOutlet weak var lblSerialValue: UILabel!
    @IBOutlet weak var lblTitleValue: UILabel!
    @IBOutlet weak var lblDetailValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
