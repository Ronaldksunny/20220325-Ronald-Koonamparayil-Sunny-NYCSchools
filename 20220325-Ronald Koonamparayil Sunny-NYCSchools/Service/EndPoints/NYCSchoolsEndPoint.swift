//
//  NYCSchoolsEndPoint.swift
//  20220325-Ronald Koonamparayil Sunny-NYCSchools
//
//

enum NYCSchoolsEndPoint: Endpoint {
    case highSchoolList
    case satScoreList
    
    var path: String {
        switch self {
        case .highSchoolList:
            return "s3k6-pzi2.json"
        case .satScoreList:
            return "734v-jeq5.json"
        }
    }
}
