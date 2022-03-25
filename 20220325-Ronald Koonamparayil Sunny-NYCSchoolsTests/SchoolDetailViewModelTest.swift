//
//  SchoolDetailViewModelTest.swift
//  20220325-Ronald Koonamparayil Sunny-NYCSchoolsTests
//
//

import XCTest

class SchoolDetailViewModelTest: XCTestCase, JsonFetchingProtocol {
    
    private var viewModel: SchoolDetailViewModel!

    override func setUpWithError() throws {
        try setupSchoolDetailViewModelIfNotAvailable()
    }
    
    func testIFSatScoreSetProperly() {
        XCTAssertEqual(viewModel.satScore?.dbn, viewModel.schoolData.dbn)
    }
    
    func testNumberOfRows() {
        XCTAssertEqual(viewModel.numberOfRows(), 3)
    }
    
    func testCellIdentifier() {
        XCTAssertEqual(viewModel.cellIdentifier(index: 0), "ScoresCell")
    }
    
    func testScoresData() {
        let data = viewModel.getScoresData()
        XCTAssertEqual(data.name, "Liberation Diploma Plus High School")
        XCTAssertEqual(data.math, "Math average score: 369")
        XCTAssertEqual(data.reading, "Reading average score: 411")
        XCTAssertEqual(data.writing, "Writing average score: 373")
    }
    
    func testContactDetails() {
        let data = viewModel.getContactDetails()
        XCTAssertEqual(data.address, "2865 West 19th Street, Brooklyn, NY, 11224")
        XCTAssertEqual(data.phoneNumber, "718-946-6812")
        XCTAssertEqual(data.website, "schools.nyc.gov/schoolportals/21/K728")
    }

    private func setupSchoolDetailViewModelIfNotAvailable() throws {
        guard viewModel == nil, let jsonData = fetchDataFromJSONFile("SchoolsList"), let detailsJson = fetchDataFromJSONFile("SatScoreList") else { XCTFail("Could not load JSON for SchoolList"); return }
        
        let schools = try JSONDecoder().decode([NYCSchool].self, from: jsonData)
        let details = try JSONDecoder().decode([SatScore].self, from: detailsJson)
        
        let model = SchoolListViewModel()
        model.schoolsList = schools
        let cell = model.schoolDataForIndex(index: 1)
        let detailsViewModel = SchoolDetailViewModel(schoolData: cell)
        detailsViewModel.setSatScore(details)
        viewModel = detailsViewModel
    }

}
