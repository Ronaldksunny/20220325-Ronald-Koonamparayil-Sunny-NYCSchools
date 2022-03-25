//
//  NYCSchoolsNetworkError.swift
//  20220325-Ronald Koonamparayil Sunny-NYCSchools
//
//
import Foundation

enum NYCSchoolsNetworkError: Error {
    case noResourceFound
    case parsingError
    case generalError
}

extension NYCSchoolsNetworkError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .noResourceFound:
            return NSLocalizedString("Sorry! no details found for your request.", comment: "")
        case .parsingError:
            return NSLocalizedString("Something went wrong. Please try again later", comment: "")
        case .generalError:
            return NSLocalizedString("Something went wrong. Please try again later", comment: "")
        }
    }
}
