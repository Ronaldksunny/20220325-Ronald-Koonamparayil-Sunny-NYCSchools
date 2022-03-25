//
//  SchoolListCellViewModel.swift
//  20220325-Ronald Koonamparayil Sunny-NYCSchools
//
//

import Foundation

struct SchoolListCellViewModel {
    let name: String
    var address: String?
    let phoneNumber: String?
    
    init(school: NYCSchool) {
        name = school.school_name
        if let first = school.primary_address_line_1, let city = school.city, let state = school.state_code, let zip = school.zip {
            address = "\(first), \(city), \(state), \(zip)"
        }
        self.phoneNumber = school.phone_number ?? ""
    }
}

