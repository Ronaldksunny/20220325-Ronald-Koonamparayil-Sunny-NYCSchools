//
//  SatScoreListRequest.swift
//  20220325-Ronald Koonamparayil Sunny-NYCSchools
//
//

import Foundation

struct SatScoreListRequest: Request {
    func createRequst() -> URLRequest? {
        return RequestManager.requestForEndpoint(NYCSchoolsEndPoint.satScoreList)
    }
    typealias ResultType = [SatScore]
}
