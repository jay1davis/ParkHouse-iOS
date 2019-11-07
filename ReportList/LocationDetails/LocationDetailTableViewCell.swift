//
//  LocationDetailTableViewCell.swift
//  ReportList
//
//  Created by Naresh kumar Nagulavancha on 3/31/19.
//  Copyright © 2019 Naresh kumar Nagulavancha. All rights reserved.
//

import UIKit

class LocationDetailTableViewCell: UITableViewCell {

    @IBOutlet var ownerLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var cityAndZipLabel: UILabel!
    @IBOutlet var countyIDLabel: UILabel!
    @IBOutlet var parcelIDLabel: UILabel!
    @IBOutlet var rsausaLabel: UILabel!
    @IBOutlet var countyNameLabel: UILabel!
    @IBOutlet var muniNameLabel: UILabel!
    @IBOutlet var stateAbbrLabel: UILabel!
    @IBOutlet var addrNumberLabel: UILabel!
    @IBOutlet var addrStPrefixLabel: UILabel!
    @IBOutlet var addrStNameLabel: UILabel!
    @IBOutlet var addrStSuffixLabel: UILabel!
    @IBOutlet var addrStTypeLabel: UILabel!
    @IBOutlet var phyCityLabel: UILabel!
    @IBOutlet var phyZipLabel: UILabel!
    @IBOutlet var censusZipLabel: UILabel!
    @IBOutlet var ownerDetailLabel: UILabel!
    @IBOutlet var mailNameLabel: UILabel!
    @IBOutlet var mailAddress1Label: UILabel!
    @IBOutlet var mailAddress2Label: UILabel!
    @IBOutlet var mailAddress3Label: UILabel!
    @IBOutlet var transDateLAbel: UILabel!
    @IBOutlet var salePriceLabel: UILabel!
    @IBOutlet var mktValueLandLabel: UILabel!
    @IBOutlet var mktValueBldgLabel: UILabel!
    @IBOutlet var mktValueTotalLabel: UILabel!
    @IBOutlet var bldgSqftLabel: UILabel!
    @IBOutlet var nghCodeLabel: UILabel!
    @IBOutlet var landUseCodeLabel: UILabel!
    @IBOutlet var landUseClassLabel: UILabel!
    @IBOutlet var storyHeightLabel: UILabel!
    @IBOutlet var munIDLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
