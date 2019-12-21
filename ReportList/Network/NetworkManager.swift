//
//  NetworkManager.swift
//  ReportList
//
//  Created by Naresh kumar Nagulavancha on 3/27/19.
//  Copyright © 2019 Naresh kumar Nagulavancha. All rights reserved.
//

import Foundation

enum ConnError: Swift.Error {
    case invalidURL
    case noData
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

struct RequestData {
    public let path: String
    public let method: HTTPMethod
    public let params: [String: Any?]?
    public let headers: [String: String]?
    public let body: Data?
    
    public init (
        path: String,
        method: HTTPMethod = .get,
        params: [String: Any?]? = nil,
        headers: [String: String]? = nil,
        body: Data? = nil
        ) {
        self.path = path
        self.method = method
        self.params = params
        self.headers = headers
        self.body = body
    }
}

protocol RequestType {
    associatedtype ResponseType: Codable
    var data: RequestData { get }
}

extension RequestType {
    func execute (
        dispatcher: NetworkDispatcher = URLSessionNetworkDispatcher.instance,
        onSuccess: @escaping (ResponseType) -> Void,
        onError: @escaping (Error) -> Void
        ) {
        dispatcher.dispatch(
            request: self.data,
            onSuccess: { (responseData: Data) in
                do {
                    let jsonDecoder = JSONDecoder()
                    let rawData = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments)
                    print(rawData)
                    let result = try jsonDecoder.decode(ResponseType.self, from: responseData)
                    print(result)
                    DispatchQueue.main.async {
                        onSuccess(result)
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        onError(error)
                    }
                }
        },
            onError: { (error: Error) in
                print(error)
                DispatchQueue.main.async {
                    onError(error)
                }
        }
        )
    }
}

protocol NetworkDispatcher {
    func dispatch(request: RequestData, onSuccess: @escaping (Data) -> Void, onError: @escaping (Error) -> Void)
}

struct URLSessionNetworkDispatcher: NetworkDispatcher {
    public static let instance = URLSessionNetworkDispatcher()
    private init() {}
    
    func dispatch(request: RequestData, onSuccess: @escaping (Data) -> Void, onError: @escaping (Error) -> Void) {
        guard let url = URL(string: request.path) else {
            onError(ConnError.invalidURL)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        do {
            if let params = request.params {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            }
            
            if let data = request.body {
                urlRequest.httpBody = data
            }
        } catch let error {
            onError(error)
            return
        }
        
        if let headers = request.headers {
            urlRequest.allHTTPHeaderFields = headers
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                onError(error)
                return
            }
            
            guard let _data = data else {
                onError(ConnError.noData)
                return
            }
            
            onSuccess(_data)
            }.resume()
    }
}

struct LocationDetails: Codable {
    let status: String?
    let count: Int?
    let page: Int?
    let rpp: Int?
    var results: [Result]? = []
    let query: String?
}
struct Result: Codable {
     let parcel_id: String?
     let county_id: String?
     let rausa_id: String?
     let county_name: String?
     let muni_name: String?
     let state_abbr: String?
     let addr_number: String?
     let addr_street_prefix: String?
     let addr_street_name: String?
     let addr_street_suffix: String?
     let addr_street_type: String?
     let physcity: String?
     let physzip: String?
     let census_zip: String?
     let owner: String?
     let mail_name: String?
     let mail_address1: String?
     let mail_address2: String?
     let mail_address3: String?
     let trans_date: String?
     let sale_price: String?
     let mkt_val_land: String?
     let mkt_val_bldg: String?
     let mkt_val_tot: String?
     let bldg_sqft: String?
     let ngh_code: String?
     let land_use_code: String?
     let land_use_class: String?
     let story_height: String?
     let muni_id: String?
     let acreage_deeded: String?
     let acreage_calc: String?
     let latitude: String?
     let longitude: String?
     let geom_as_wkt: String?
     let school_dist_id: String?
}

struct GetLocation: RequestType {
    typealias ResponseType = LocationDetails
    var params: [String: Any?] = [
        "client": "54RY88KDHy",
        "v":"2",
        "spatial_intersect":"POINT(-84.3350391 33.7129586)",
        "si_srid":"4326"
    ]
    var data: RequestData {
        return RequestData(path: "https://reportallusa.com/api/parcels.php", method: .post, params: params)
    }
    
}
