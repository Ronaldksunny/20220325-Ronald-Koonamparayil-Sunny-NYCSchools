//
//  SchoolListViewModel.swift
//  20220325-Ronald Koonamparayil Sunny-NYCSchools
//

import Foundation
import UIKit

class SchoolListViewModel {
    var schoolsList = [NYCSchool]()
    var filteredSchoolsList = [NYCSchool]()
    var needsRefreshPage: (() -> Void)? = nil
    var handleError: ((Error) -> Void)? = nil
    var isFiltering: Bool = false
    
    func fetchData() {
        NYCSchoolsInteractor.fetchSchools { [weak self] (result, error) in
            
            if let err = error {
                self?.handleError?(err)
            }
            
            guard let list = result else { return }
            DispatchQueue.main.async {
                self?.schoolsList = list
                self?.needsRefreshPage?()
            }
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredSchoolsList = (schoolsList.filter({( schools : NYCSchool) -> Bool in
            return schools.school_name.lowercased().contains(searchText.lowercased())
        }))
        needsRefreshPage?()
    }
    
    func numberOfRows() -> Int {
        guard isFiltering else { return schoolsList.count }
        return self.filteredSchoolsList.count
    }
    
    func schoolDataForIndex(index: Int) -> NYCSchool {
        guard isFiltering else { return schoolsList[index] }
        return filteredSchoolsList[index]
    }
    
    func cellDataForIndex(index: Int) -> SchoolListCellViewModel {
        let schoolData = schoolDataForIndex(index: index)
        return SchoolListCellViewModel(school: schoolData)
    }
}
