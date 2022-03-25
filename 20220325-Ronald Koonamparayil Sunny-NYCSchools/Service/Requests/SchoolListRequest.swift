//
//  SchoolListRequest.swift
//  20220325-Ronald Koonamparayil Sunny-NYCSchools
//
//

import Foundation

struct SchoolListRequest: Request {
    func createRequst() -> URLRequest? {
        return RequestManager.requestForEndpoint(NYCSchoolsEndPoint.highSchoolList)
    }
    typealias ResultType = [NYCSchool]
}
