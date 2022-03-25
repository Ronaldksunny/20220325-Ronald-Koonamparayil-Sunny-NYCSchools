//
//  SchoolListCellViewModelTest.swift
//  20220325-Ronald Koonamparayil Sunny-NYCSchoolsTests
//
//

import XCTest

class SchoolListCellViewModelTest: XCTestCase, JsonFetchingProtocol {
    
    private var viewModel: SchoolListCellViewModel!
    
    override func setUpWithError() throws {
        setupSchoolListCellIfNotAvailable()
    }

    func testName() {
        XCTAssertEqual(viewModel.name, "Liberation Diploma Plus High School")
    }
    
    func testAddress() {
        XCTAssertEqual(viewModel.address, "2865 West 19th Street, Brooklyn, NY, 11224")
    }
    
    func testPhoneNumber() {
        XCTAssertEqual(viewModel.phoneNumber, "718-946-6812")
    }
    
    
    private func setupSchoolListCellIfNotAvailable() {
        guard viewModel == nil, let jsonData = fetchDataFromJSONFile("SchoolsList") else { XCTFail("Could not load JSON for SchoolList"); return }
        guard let schools = try? JSONDecoder().decode([NYCSchool].self, from: jsonData) else {
            XCTFail("Failed to decode json to SchoolList"); return
        }
        let model = SchoolListViewModel()
        model.schoolsList = schools
        let cell = model.cellDataForIndex(index: 1)
        viewModel = cell
    }

}
