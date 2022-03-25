//
//  NYCSchoolsInteractor.swift
//  20220325-Ronald Koonamparayil Sunny-NYCSchools
//
//

import Foundation

struct NYCSchoolsInteractor {
    
    static func fetchSchools(completion: @escaping ([NYCSchool]?, Error?) -> Void) {
        let request = SchoolListRequest()
        ServiceHandler.performRequest(request) { (result, error) in
            guard let result = result else { completion(nil, error); return }
            completion(result, nil)
        }
    }
    
    static func fetchSatScore(completion: @escaping ([SatScore]?, Error?) -> Void) {
        let request = SatScoreListRequest()
        ServiceHandler.performRequest(request) { (result, error) in
            guard let result = result else { completion(nil, error); return }
            completion(result, nil)
        }
    }
}

