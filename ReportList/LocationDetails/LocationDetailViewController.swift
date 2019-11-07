//
//  LocationDetailViewController.swift
//  ReportList
//
//  Created by Naresh kumar Nagulavancha on 3/31/19.
//  Copyright © 2019 Naresh kumar Nagulavancha. All rights reserved.
//

import UIKit
import CoreData

fileprivate let locationDetailCell = "LocationDetailTableViewCell"

class LocationDetailViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var locations: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: locationDetailCell, bundle: nil), forCellReuseIdentifier: locationDetailCell)

        // Do any additional setup after loading the view.
    }

}

extension LocationDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: locationDetailCell, for: indexPath) as! LocationDetailTableViewCell
        let location = locations[indexPath.row]
        cell.ownerLabel.text = location.value(forKey: "owner") as? String
        cell.addressLabel.text = location.value(forKey: "address1") as? String
        cell.cityAndZipLabel.text = location.value(forKey: "address3") as? String
        cell.countyIDLabel.text = location.value(forKey: "countyID") as? String
        cell.parcelIDLabel.text = location.value(forKey: "parcelID") as? String
        cell.rsausaLabel.text = location.value(forKey: "rsauaID") as? String
        cell.countyNameLabel.text = location.value(forKey: "countyName") as? String
        cell.muniNameLabel.text = location.value(forKey: "muniName") as? String
        cell.stateAbbrLabel.text = location.value(forKey: "stateAbbr") as? String
        cell.addrNumberLabel.text = location.value(forKey: "addressNumber") as? String
        cell.addrStPrefixLabel.text = location.value(forKey: "addressStreetPrefix") as? String
        cell.addrStNameLabel.text = location.value(forKey: "addressNumber") as? String
        cell.addrStSuffixLabel.text = location.value(forKey: "addressStreetSuffix") as? String
        cell.addrStTypeLabel.text = location.value(forKey: "addressStreetType") as? String
        cell.phyCityLabel.text = location.value(forKey: "physicalCity") as? String
        cell.phyZipLabel.text = location.value(forKey: "physicalZip") as? String
        cell.censusZipLabel.text = location.value(forKey: "censusZip") as? String
        cell.ownerDetailLabel.text = location.value(forKey: "owner") as? String
        cell.mailNameLabel.text = location.value(forKey: "mailName") as? String
        cell.mailAddress1Label.text = location.value(forKey: "mailAddress1") as? String
        cell.mailAddress2Label.text = location.value(forKey: "mailAddress2") as? String
        cell.mailAddress3Label.text = location.value(forKey: "mailAddress3") as? String
        cell.transDateLAbel.text = location.value(forKey: "transDate") as? String
        cell.salePriceLabel.text = location.value(forKey: "salePrice") as? String
        cell.mktValueLandLabel.text = location.value(forKey: "mktValueLand") as? String
        cell.mktValueBldgLabel.text  = location.value(forKey: "mktValueBldg") as? String
        cell.mktValueTotalLabel.text = location.value(forKey: "mktValueTotal") as? String
        cell.bldgSqftLabel.text = location.value(forKey: "bldgSqft") as? String
        cell.nghCodeLabel.text = location.value(forKey: "nghCode") as? String
        cell.landUseCodeLabel.text = location.value(forKey: "landUseCode") as? String
        cell.landUseClassLabel.text = location.value(forKey: "landUseClass") as? String
        cell.storyHeightLabel.text = location.value(forKey: "storyHeight") as? String
        cell.munIDLabel.text = location.value(forKey: "munID") as? String

        return cell
    }
}
