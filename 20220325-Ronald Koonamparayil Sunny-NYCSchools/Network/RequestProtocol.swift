//
//  RequestProtocol.swift
//  20220325-Ronald Koonamparayil Sunny-NYCSchools
//
//

import Foundation

protocol Request {
    associatedtype ResultType: Decodable
    func createRequst() -> URLRequest?
}
