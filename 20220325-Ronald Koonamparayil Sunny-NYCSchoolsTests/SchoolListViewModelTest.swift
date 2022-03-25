//
//  SchoolListViewModelTest.swift
//  20220325-Ronald Koonamparayil Sunny-NYCSchoolsTests
//
//

import XCTest

class SchoolListViewModelTest: XCTestCase, JsonFetchingProtocol {

    private var viewModel: SchoolListViewModel!

    override func setUpWithError() throws {
        setupViewModelIfNotAvailable()
    }

    override func tearDownWithError() throws {
        viewModel.isFiltering = false
    }
    
    func testNumberOfRows() {
        XCTAssertEqual(viewModel.numberOfRows(), 440)
    }
    
    func testFilterContentForSearchText() {
        viewModel.filterContentForSearchText("bronx")
        XCTAssertEqual(viewModel.filteredSchoolsList.count, 40)
    }
    
    func testIsFilteringReturnsCorrectFilterList() {
        viewModel.filterContentForSearchText("bronx")
        viewModel.isFiltering = true
        XCTAssertEqual(viewModel.numberOfRows(), 40)
    }
    
    func testSchoolDataForIndex() {
        let school = viewModel.schoolDataForIndex(index: 1)
        XCTAssertEqual(school.school_name, "Liberation Diploma Plus High School")
        XCTAssertEqual(school.dbn, "21K728")
    }
    
    private func setupViewModelIfNotAvailable() {
        guard viewModel == nil, let jsonData = fetchDataFromJSONFile("SchoolsList") else { XCTFail("Could not load JSON for SchoolList"); return }
        guard let schools = try? JSONDecoder().decode([NYCSchool].self, from: jsonData) else {
            XCTFail("Failed to decode json to SchoolList"); return
        }
        let model = SchoolListViewModel()
        model.schoolsList = schools
        viewModel = model
    }

}
