//
//  Organization.swift
//  ReportList
//
//  Created by Naresh Nagulavancha on 11/7/19.
//  Copyright © 2019 Naresh kumar Nagulavancha. All rights reserved.
//

import Foundation

struct Organization: Encodable {
    var name: String = ""
    var country_code: String = ""
    var update_time: String = ""
    var add_time: String = ""
    var visible_to: String = "3"
    var next_activity_date: String = ""
    var next_activity_time: String = ""
    var next_activity_id: String = ""
    var last_activity_id: String = ""
    var last_activity_date: String = ""
    var address: String = ""
    var address_subpremise: String = ""
    var address_street_number: String = ""
    var address_route: String = ""
    var address_sublocality: String = ""
    var address_locality: String = ""
    var address_admin_area_level_1: String = ""
    var address_admin_area_level_2: String = ""
    var address_country: String = ""
    var address_postal_code: String = ""
    var address_formatted_address: String = ""
    var parcelCounty: String = ""
    var parcelNumber: String = ""
    var taxAssessedValue: String = ""
    var lastSalePrice: String = ""
    var lastSaleDate: String = ""
    var zoning: String = ""
    var not_used: String = ""
    var landArea : String = "0"
    var category: String = ""
    var recordedOwner: String = ""
    
    enum CodingKeys: String, CodingKey {
        case name
        case country_code
        case update_time
        case add_time
        case visible_to
        case next_activity_date
        case next_activity_time
        case next_activity_id
        case last_activity_id
        case last_activity_date
        case address
        case address_subpremise
        case address_street_number
        case address_route
        case address_sublocality
        case address_locality
        case address_admin_area_level_1
        case address_admin_area_level_2
        case address_country
        case address_postal_code
        case address_formatted_address
        case parcelCounty = "299b53734cb69acff005c62628c05ee4acec790d"
        case parcelNumber = "3f6cbe871d0167426d18af2187a1174d8ecb02f5"
        case taxAssessedValue = "7b5fdf1a6fa68d4b55db8b015b386b193b1455ed"
        case lastSalePrice = "4f6908c752dd5b3f42b6d5b0039d8dd22670fb65"
        case lastSaleDate = "38bbe8c3262cc801aae84c7552a81594210b0892"
        case zoning = "8673cf7745b6b2ae053c02ca2b816ecdb80f7fe3"
        case not_used = "08219357300cd4baeb829d1f7eef317f88445760"
        case landArea = "1bc533d71b783cfbdb8b04fa2fa20289ee2245b5"
        case category = "24cd202b89b576613d60bc25b8be7296da81309b"
        case recordedOwner = "f829aa4b5d02943870943676a14331c083045cef"
    }
    
    init?(location: LocationViewModel) {
        guard let result = location.getLocation().results?.first else { return nil }
        name = result.owner ?? result.mail_name ?? "Our Neighbor"
        country_code = "US"
        let formatter  = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        let date = formatter.string(from: Date())
        update_time = date
        add_time = date
        visible_to = "3"
        
        let addresses = location.getAdress()
        self.address = "\(addresses.0) \(addresses.2)"
        //subpremis is empty
        self.address_street_number = result.addr_number ?? ""
        self.address_route = result.addr_street_name ?? ""
        //sublocality is empty
        self.address_locality = result.physcity ?? ""
        self.address_admin_area_level_1 = result.state_abbr ?? ""
        self.address_admin_area_level_2 = result.county_name ?? ""
        self.address_country = "United States"
        self.address_postal_code = result.physzip ?? ""
        self.address_formatted_address = "\(addresses.0) \(addresses.2)"
        self.parcelCounty = result.county_name ?? ""
        self.parcelNumber = result.parcel_id ?? ""
        self.taxAssessedValue = result.mkt_val_tot ?? "0"
        self.lastSalePrice = result.sale_price ?? "0"
        self.lastSaleDate = result.trans_date ?? ""
        self.zoning = result.land_use_code ?? ""
        self.category = location.getCategory()
        self.recordedOwner = result.owner ?? ""
        self.landArea = result.acreage_deeded ?? "0"
        // land area is empty
//            self.parcelCounty = result.parce
        
        address_street_number = result.addr_number ?? ""
    }
}

struct OrganizationResponse: Codable {
    let success: Bool
    let data: Org
}

struct Org: Codable {
    let id: UInt64
    let owner_id: Owner
}

struct Owner: Codable {
    let id: UInt64
}

struct GetOrganization: RequestType {
    typealias ResponseType = OrganizationResponse
    var location: LocationViewModel
    
    init(location: LocationViewModel) {
        self.location = location
    }

    var headers: [String: String] = ["Content-Type": "application/json"]
    
    var data: RequestData {
        let data = Organization(location: location)
        do {
            let encodedData = try JSONEncoder().encode(data)
            return RequestData(path: "https://recapp-sandbox-24b76d.pipedrive.com/v1/organizations?api_token=7f8bfc2b4fc6cd6533c5a5cc2f7342cf36d9d1ba", method: .post, headers: headers, body: encodedData)
        }
        catch {
            fatalError("Could not encode data")
        }
    }
    
}
