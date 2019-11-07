//
//  Ledger.swift
//  ReportList
//
//  Created by Naresh Nagulavancha on 11/7/19.
//  Copyright © 2019 Naresh kumar Nagulavancha. All rights reserved.
//

import Foundation


struct LedgerBody: Codable {
    var email: String = ""
    var user: String = ""
    var timestamp: String = ""
    var category: String = ""
    var parcelId: String = ""
    var countyId: String = ""
    var rausaId: String = ""
    var countyName: String = ""
    var muniName: String = ""
    var stateAbbr: String = ""
    var addrNumber: String = ""
    var addrStreetPrefix:String = ""
    var addrStreetName: String = ""
    var addrStreetSuffix: String = ""
    var addrStreetType: String = ""
    var physcity: String = ""
    var physzip: String = ""
    var censusZip:String = ""
    var owner: String = ""
    var mailName: String = ""
    var mailAddress1: String = ""
    var mailAddress2: String = ""
    var mailAddress3: String = ""
    var transDate: String = ""
    var salePrice: String = ""
    var mktValLand: String = ""
    var mktValBldg: String = ""
    var mktValTot: String = ""
    var bldgSqft:String = ""
    var nghCode: String = ""
    var landUseCode: String = ""
    var landUseClass: String = ""
    var storyHeight: String = ""
    var muniId: String = ""
    var schoolDistId: String = ""
    var acreageDeeded: String = ""
    var acreageCalc:String = ""
    var point: Point
    var polygon: Polygon
    
    init?(location: LocationViewModel) {
        email = "test@gmail.com"
        user = "test"
        guard let result = location.getLocation().results?.first else { return nil }
        category = location.getCategory()
        parcelId = result.parcel_id ?? ""
        countyId = result.county_id ?? ""
        rausaId = result.rausa_id ?? ""
        countyName = result.county_name ?? ""
        muniName = result.muni_name ?? ""
        stateAbbr = result.state_abbr ?? ""
        addrNumber = result.addr_number ?? ""
        addrStreetPrefix = result.addr_street_prefix ?? ""
        addrStreetName = result.addr_street_name ?? ""
        addrStreetSuffix = result.addr_street_suffix ?? ""
        addrStreetType = result.addr_street_type ?? ""
        physcity = result.physcity ?? ""
        physzip = result.physzip ?? ""
        censusZip = result.census_zip ?? ""
        owner = result.owner ?? ""
        mailName = result.mail_name ?? ""
        mailAddress1 = result.mail_address1 ?? ""
        mailAddress2 = result.mail_address2 ?? ""
        mailAddress3 = result.mail_address3 ?? ""
        transDate = result.trans_date ?? ""
        salePrice = result.sale_price ?? ""
        mktValLand = result.mkt_val_land ?? ""
        mktValBldg = result.mkt_val_bldg ?? ""
        mktValTot = result.mkt_val_tot ?? ""
        bldgSqft = result.bldg_sqft ?? ""
        nghCode = result.ngh_code ?? ""
        landUseCode = result.land_use_code ?? ""
        landUseClass = result.land_use_class ?? ""
        storyHeight = result.story_height ?? ""
        muniId = result.muni_id ?? ""
        schoolDistId = result.school_dist_id ?? ""
        acreageDeeded = result.acreage_deeded ?? ""
        acreageCalc = result.acreage_calc ?? ""
        point = Point(type: "Point", coordinates: location.getPoint())
        polygon = Polygon(type: "Polygon", coordinates: [location.getPolygonPoints()])
    }
}

struct Point:Codable {
    let type: String
    let coordinates: [Double]
}

struct Polygon: Codable {
    let type: String
    let coordinates: [[[Double]]]
}

struct LedgerResponse: Codable {
    let code: Int
    let success: Success
}

struct Success: Codable {
    let msg: String
}

struct GetLedger: RequestType {
    typealias ResponseType = LedgerResponse
    let location: LocationViewModel
    
    var headers: [String: String] = [
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVkMzFkN2MyN2ZhYzNjNDYyZDc1OWNkYSIsImlhdCI6MTU2NTEzNjcxNX0.9iNuzko3Hyt9R4_6RrjMpmuNNp3rS39maWU0ll47mJo"
    ]
    
    init(location: LocationViewModel) {
        self.location = location
    }
    
    var data: RequestData {
        let data = LedgerBody(location: location)
        do {
            let encodedData = try JSONEncoder().encode(data)
            return RequestData(path: "https://leadgeneratorapp.com/poi", method: .post, headers: headers, body: encodedData)
        }
        catch {
            fatalError("Could not encode data")
        }
     }
}
