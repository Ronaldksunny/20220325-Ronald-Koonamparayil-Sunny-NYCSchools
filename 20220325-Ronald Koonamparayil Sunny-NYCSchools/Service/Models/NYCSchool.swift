//
//  NYCSchool.swift
//  20220325-Ronald Koonamparayil Sunny-NYCSchools
//
//

struct NYCSchool: Decodable {
    let dbn: String?
    let school_name: String
    let overview_paragraph: String?
    var location: String?
    let primary_address_line_1: String?
    let city: String?
    let zip: String?
    let state_code: String?
    let latitude: String?
    let longitude: String?
    let website:String?
    let phone_number: String?
}
