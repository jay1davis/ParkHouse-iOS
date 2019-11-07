//
//  Person.swift
//  ReportList
//
//  Created by Naresh Nagulavancha on 11/7/19.
//  Copyright © 2019 Naresh kumar Nagulavancha. All rights reserved.
//

import Foundation

import Foundation

struct Person: Encodable {
    var name: String = ""
    var label: String = "blank"
    var phone: String = ""
    var email: String = ""
    var add_time: String = "blank"
    var update_time: String = ""
    var org_id: UInt32 = 0
    var owner_id: UInt64 = 0
    var open_deals_count: UInt = 0
    var visible_to: String = ""
    var next_activity_date: String = ""
    var last_activity_date: String = ""
    var notes: String = "notes"
    var altPhone: String = ""
    var mail_zip: String = ""
    var mail_state: String = ""
    var mail_city: String = ""
    var mail_street: String = ""
    var mail_street2: String = ""
    
    enum CodingKeys: String, CodingKey {
        case name
        case label
        case phone
        case email
        case add_time
        case update_time
        case org_id
        case owner_id
        case open_deals_count
        case visible_to
        case next_activity_date
        case last_activity_date
        case notes = "6a16923a363578d178c28029f331d20b4bffbbcc"
        case altPhone = "116bb7de2c24161b7cdd8b8060005bba744b5f83"
        case mail_zip = "bcf82ddc65cc3a826bbfdc9f64ec6c5579b5aeb1"
        case mail_state = "0bc9970fdd4ac530b0ef8dd4a034cd8f689c2f8d"
        case mail_city = "c3b0c5418a1db787445c079a32dd656b08735ba6"
        case mail_street = "e2321f7ea9ed319cedef8f39b7cc78263eb344ae"
        case mail_street2 = "de0504485bd6592d8b1266ef8bfd694796dc1bab"
    }
    
    init(location: LocationDetails) {
        
    }
}

struct PersonResponse: Codable {
    let success: Bool
}

struct GetPerson: RequestType {
    typealias ResponseType = PersonResponse
    var data: RequestData {
        return RequestData(path: "https://recapp-sandbox-24b76d.pipedrive.com/v1/persons?api_token=7f8bfc2b4fc6cd6533c5a5cc2f7342cf36d9d1ba", method: .post)
    }
}
