//
//  ViewController.swift
//  ReportList
//
//  Created by Naresh kumar Nagulavancha on 3/27/19.
//  Copyright © 2019 Naresh kumar Nagulavancha. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreData

class ViewController: UIViewController {

    var locationManager = CLLocationManager()
    
    @IBOutlet var mapView: GMSMapView!
    @IBOutlet var helperView: UIView!
    @IBOutlet var chooseButton: DropDownButton!
    @IBOutlet var ownerLabel: UILabel!
    @IBOutlet var addressLabel1: UILabel!
    @IBOutlet var addressLabel2: UILabel!
    @IBOutlet var navigateButton: UIButton!
    @IBOutlet var saveButton: UIButton!
    
    
    let chooseCategory = DropDown()
    var tempLocationDetails: LocationDetails? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        helperView.layer.cornerRadius = 5
        
        setUpCategory()
        
        // Do any additional setup after loading the view.
        self.mapView.mapType = kGMSTypeHybrid
        self.mapView.delegate = self
        
        //Location Manager code to fetch current location
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    
        
        GetLocation().execute(onSuccess: { (location: LocationDetails) in
            // Do something with users
            print(location)
        },
        onError: { (error: Error) in
            // Do something with error
            print(error)
        })
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        helperView.isHidden = true
    }
    
    @IBAction func chooseCategoryTapped(_ sender: Any) {
        chooseCategory.show()
    }
    
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        save()
    }
    
    func save() {
        guard let location = tempLocationDetails else {
            return
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Locations", in: context)
        let newLocation = NSManagedObject(entity: entity!, insertInto: context)
        let result = location.results?.first
        let addresses = getAdress()
        let formatter  = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy HH:mm"
        let date = formatter.string(from: Date())
        var category = ""
        if let item = chooseCategory.selectedItem {
            category = item
        } else {
            category = "N/A"
        }
        newLocation.setValue(result?.acreage_calc ?? "", forKey: "acreageCalc")
        newLocation.setValue(result?.acreage_deeded, forKey: "acreageDeeded")
        
        //address 1
        newLocation.setValue(addresses.0, forKey: "address1")
        // address 2
        newLocation.setValue(addresses.1, forKey: "address2")
        // address 3
        newLocation.setValue(addresses.2, forKey: "address3")
        newLocation.setValue(result?.addr_number, forKey: "addressNumber")
        newLocation.setValue("", forKey: "addressStreetName")
        newLocation.setValue(result?.addr_street_prefix, forKey: "addressStreetPrefix")
        newLocation.setValue(result?.addr_street_suffix, forKey: "addressStreetSuffix")
        newLocation.setValue(result?.addr_street_type, forKey: "addressStreetType")
        newLocation.setValue(result?.bldg_sqft, forKey: "bldgSqft")
        newLocation.setValue(result?.census_zip, forKey: "censusZip")
        newLocation.setValue(result?.physcity, forKey: "city")
        newLocation.setValue(result?.county_id, forKey: "countyID")
        newLocation.setValue(result?.county_name, forKey: "countyName")
        newLocation.setValue(result?.land_use_class, forKey: "landUseClass")
        newLocation.setValue(result?.land_use_code, forKey: "landUseCode")
        newLocation.setValue(result?.latitude, forKey: "latitude")
        newLocation.setValue(result?.longitude, forKey: "longitude")
        newLocation.setValue(result?.mail_address1, forKey: "mailAddress1")
        newLocation.setValue(result?.mail_address2, forKey: "mailAddress2")
        newLocation.setValue(result?.mail_address3, forKey: "mailAddress3")
        newLocation.setValue(result?.mail_name, forKey: "mailName")
        newLocation.setValue(result?.mkt_val_bldg, forKey: "mktValueBldg")
        newLocation.setValue(result?.mkt_val_land, forKey: "mktValueLand")
        newLocation.setValue(result?.mkt_val_tot, forKey: "mktValueTotal")
        newLocation.setValue(result?.muni_id, forKey: "munID")
        newLocation.setValue(result?.muni_name, forKey: "muniName")
        newLocation.setValue(result?.ngh_code, forKey: "nghCode")
        newLocation.setValue(result?.owner, forKey: "owner")
        newLocation.setValue(result?.parcel_id, forKey: "parcelID")
        newLocation.setValue(result?.physcity, forKey: "physicalCity")
        newLocation.setValue(result?.physzip, forKey: "physicalZip")
        newLocation.setValue(result?.rausa_id, forKey: "rsauaID")
        newLocation.setValue(result?.sale_price, forKey: "salePrice")
        newLocation.setValue(result?.school_dist_id, forKey: "schoolDistID")
        newLocation.setValue(result?.state_abbr, forKey: "stateAbbr")
        newLocation.setValue(result?.story_height, forKey: "storyHeight")
        newLocation.setValue(result?.trans_date, forKey: "transDate")
        newLocation.setValue(date, forKey: "date")
        newLocation.setValue(result?.physzip, forKey: "zip")
        newLocation.setValue(category, forKey: "category")
        
        do {
            try context.save()
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Locations")
            //request.predicate = NSPredicate(format: "age = %@", "12")
            request.returnsObjectsAsFaults = false
            do {
                let result = try context.fetch(request)
                print(result)
                
            } catch {
                
                print("Failed")
            }
        } catch {
            print("Failed saving")
        }
        
        
    }
    
    func getAdress() -> (String, String, String){
        guard let result = tempLocationDetails?.results?.first else {
            return ("", "", "")
        }
        
        var addressLine1 = ""
        var addressLine2 = ""
        var addressLine3 = ""
        
        let addressNumber = result.addr_number?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let addressPrefix = result.addr_street_prefix?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let addressStreetName = result.addr_street_name?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let addressType = result.addr_street_type?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let addressSuffix = result.addr_street_suffix?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let addressCity = result.physcity?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let addressState = result.state_abbr?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let zip = result.physzip?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        addressLine1 = addressNumber + " " + addressPrefix + " " +  addressStreetName + " " + addressType + " " + addressSuffix
        addressLine3 = addressCity + " " + addressState + " " + zip
        
        if addressLine1.replacingOccurrences(of: " ", with: "") == "" &&  addressLine2.replacingOccurrences(of: " ", with: "") == "" {
            addressLine1 = result.mail_address1 ?? ""
            addressLine2 = result.mail_address2 ?? ""
            addressLine3 = result.mail_address3 ?? ""
        }
        
        return (addressLine1, addressLine2, addressLine3)
        
    }
    
    func setUpCategory() {
        chooseCategory.anchorView = chooseButton
    
        chooseCategory.bottomOffset = CGPoint(x: 0, y: chooseButton.bounds.height)
        
        chooseCategory.dataSource = ["Distressed Commercial", "Commercial Lot", "Retail/Car Wash Site", "Triple Net Lease Site", "Apartments", "Hotel", "Developer", "Distressed Residential", "Residential Lots"]
        
        chooseCategory.selectionAction = { [weak self] (index, item) in
            self?.chooseButton.setTitle(item, for: .normal)
        }
    }
    
}

extension ViewController: CLLocationManagerDelegate {
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        
        self.mapView?.animate(to: camera)
        
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()
        
    }

}

extension ViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        self.helperView.isHidden = true
    }
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        print("Coordinates: \(coordinate.latitude), \(coordinate.longitude)")
        mapView.clear()
        var locationService = GetLocation()
        locationService.params["spatial_intersect"] = "POINT(\(coordinate.longitude) \(coordinate.latitude))"
        locationService.execute(onSuccess: { (location: LocationDetails) in
            // Do something with users
            self.tempLocationDetails = location
            let addresses = self.getAdress()
            DispatchQueue.main.async {
                self.ownerLabel.text = location.results?.first?.owner ?? "Not available"
                self.addressLabel1.text = addresses.0
                self.addressLabel2.text = addresses.2
            }
            let path = GMSMutablePath()
            let coordinates = location.results?.first?.geom_as_wkt
            
            guard let locations = coordinates  else {
                return
            }
            for i in locations.getLocations() {
                path.add(i)
            }
            
            let polyLine = GMSPolyline(path: path)
            polyLine.strokeColor = UIColor.red
            polyLine.strokeWidth = polyLine.strokeWidth + 1
            polyLine.map = mapView
            if self.helperView.isHidden {
                UIView.animate(withDuration: 0.2, animations: {
                    self.helperView.isHidden = false
                })
            }
        },
                                onError: { (error: Error) in
                                    // Do something with error
                                    print(error)
        })
    }
}

extension String {
    func getLocations() -> [CLLocationCoordinate2D] {
        let mod = self.replacingOccurrences(of: "MULTIPOLYGON", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "")
        let locations = mod.split(separator: ",").map {
            String($0)
        }
        
        if locations.count < 1 {
            return []
        }
        
        let coordinates = locations.map {
            (input: String) -> CLLocationCoordinate2D in
            let ar = input.split(separator: " ").map( {Double($0)!})
            return CLLocationCoordinate2D(latitude: ar.last!, longitude: ar.first!)
        }
        
        return coordinates
    }
}

