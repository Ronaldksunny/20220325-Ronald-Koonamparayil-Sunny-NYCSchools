//
//  JsonFetchingProtocol.swift
//  20220325-Ronald Koonamparayil Sunny-NYCSchoolsTests
//
//

import Foundation

protocol JsonFetchingProtocol {
    func fetchDataFromJSONFile(_ filename: String) -> Data?
}

extension JsonFetchingProtocol {
    func fetchDataFromJSONFile(_ filename: String) -> Data? {
        guard let path = Bundle(for: BundleFinder.self).path(forResource: filename, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                return nil
        }
        return data
    }
}

private class BundleFinder {}

