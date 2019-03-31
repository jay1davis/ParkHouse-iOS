//
//  LocationListTableViewCell.swift
//  ReportList
//
//  Created by Naresh kumar Nagulavancha on 3/30/19.
//  Copyright © 2019 Naresh kumar Nagulavancha. All rights reserved.
//

import UIKit

class LocationListTableViewCell: UITableViewCell {
    @IBOutlet var ownerLabel: UILabel!
    @IBOutlet var addressLine1Label: UILabel!
    @IBOutlet var zipcodeLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
