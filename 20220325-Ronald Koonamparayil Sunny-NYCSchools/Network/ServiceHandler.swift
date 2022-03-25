//
//  ServiceHandler.swift
//  20220325-Ronald Koonamparayil Sunny-NYCSchools
//
//

import Foundation

struct ServiceHandler<T: Request> {
    static func performRequest(_ request: T, _ completion:@escaping (T.ResultType?, Error?)  -> Void)
    {
        let session = URLSession.shared
        guard let urlRequest = request.createRequst() else {  return completion(nil, NYCSchoolsNetworkError.generalError) }
        session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let _ = error {
                return completion(nil, error)
            }
            
            guard let responseData = data else { return completion(nil, NYCSchoolsNetworkError.noResourceFound) }
            
            do {
                let result = try JSONDecoder().decode(T.ResultType.self, from: responseData)
                return completion(result, nil)
            } catch {
                return completion(nil , NYCSchoolsNetworkError.parsingError)
            }
        }.resume()
    }
}

extension ServiceHandler where T.ResultType == Data {
    static func performRequest(_ request: T, _ completion:@escaping (T.ResultType?, Error?) -> Void)
    {
        let session = URLSession.shared
        guard let urlRequest = request.createRequst() else {  return completion(nil, NYCSchoolsNetworkError.generalError) }
        session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let _ = error {
                return completion(nil, error)
            }

            guard let responseData = data else { return completion(nil, NYCSchoolsNetworkError.noResourceFound) }
            return completion(responseData , nil)

        }.resume()
    }
}
