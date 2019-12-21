//
//  LocationViewModel.swift
//  ReportList
//
//  Created by Naresh Nagulavancha on 11/7/19.
//  Copyright © 2019 Naresh kumar Nagulavancha. All rights reserved.
//

import CoreData
import UIKit
import GoogleMaps

class LocationViewModel {
    private var location: LocationDetails
    private var category: String
    private var point: CLLocationCoordinate2D
    private var polygonPoints: [CLLocationCoordinate2D]
    
    init(location: LocationDetails, category: String, point: CLLocationCoordinate2D, points: [CLLocationCoordinate2D]) {
        self.location = location
        self.category = category
        self.point = point
        self.polygonPoints = points
    }
    
    
    func getLocation() -> LocationDetails {
        return location
    }
        
    func getCategory() -> String {
        return category
    }
    
    func getPoint() -> [Double] {
        return [point.latitude, point.longitude]
    }
    
    func getPolygonPoints() -> [[Double]] {
        return polygonPoints.map {
            return [$0.longitude, $0.latitude]
        }
    }
    
    func setLocation(location: LocationDetails) {
        self.location = location
    }
    
    func setCategory(cat: String) {
        self.category = cat
    }
    
    func save(isSuccess: (Bool) -> Void) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Locations", in: context)
        let newLocation = NSManagedObject(entity: entity!, insertInto: context)
        let result = location.results?.first
        let addresses = getAdress()
        let formatter  = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy HH:mm"
        let date = formatter.string(from: Date())
        
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
                isSuccess(false)
            }
            isSuccess(true)
        } catch {
            print("Failed saving")
            isSuccess(false)
        }
        
        
    }
    
    func getAdress() -> (String, String, String){
        guard let result = location.results?.first else {
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
    
    func sendAllRequests() {
        let ledgerService = GetLedger(location: self)
        let organizationService = GetOrganization(location: self)
        var personService = GetPerson(location: self)
        
        let myGroup = DispatchGroup()
        
        myGroup.enter()
        organizationService.execute(onSuccess: { (orgResponse: OrganizationResponse) in
            personService.orgResponse = orgResponse
            personService.execute(onSuccess: { (personResponse: PersonResponse) in
                myGroup.leave()
            }, onError: { (error) in
                myGroup.leave()
            })
        }, onError: { (error) in
           myGroup.leave()
        })
        
        myGroup.enter()
        ledgerService.execute(onSuccess: { (ledgerResponse: LedgerResponse) in
            myGroup.leave()
        }, onError: { (error) in
            myGroup.leave()
        })
        
        myGroup.notify(queue: .main) {
            print("Finished all requests")
        }
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
