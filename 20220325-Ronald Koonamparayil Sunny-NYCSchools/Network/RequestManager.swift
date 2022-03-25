//
//  RequestManager.swift
//  20220325-Ronald Koonamparayil Sunny-NYCSchools
//
//

import Foundation

struct RequestManager {
    static func requestForEndpoint(_ endpoint: Endpoint, httpMethod: HTTPMethod = .GET, path: String? = nil) -> URLRequest? {
        var fullPath =  ServiceConstants.baseURL + endpoint.path
        if let path = path {
            fullPath = path
        }
        guard let url = URL(string: fullPath) else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
