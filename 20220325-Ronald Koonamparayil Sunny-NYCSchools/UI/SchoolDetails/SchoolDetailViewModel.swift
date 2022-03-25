//
//  SchoolDetailViewModel.swift
//  20220325-Ronald Koonamparayil Sunny-NYCSchools
//

import UIKit

enum DetailsViewCellType: Int, CaseIterable {
    case score
    case overview
    case contact
    
    var cellIdentifier: String {
        switch self {
        case .score:
            return "ScoresCell"
        case .overview:
            return "OverviewCell"
        case .contact:
            return "ContactCell"
        }
    }
}

class SchoolDetailViewModel {
    let schoolData: NYCSchool
    var satScore: SatScore?
    var needsRefreshPage: (()->Void)? = nil
    var handleError: ((Error) -> Void)? = nil
    
    init(schoolData: NYCSchool) {
        self.schoolData = schoolData
    }
    
    func fetchData() {
        NYCSchoolsInteractor.fetchSatScore { [weak self] (result, error) in
            
            if let err = error {
                self?.handleError?(err)
            }
            
            guard let list = result else { return }
            self?.setSatScore(list)
        }
    }
    
    func setSatScore(_ list: [SatScore]) {
        guard let satScore = list.filter({ $0.dbn == schoolData.dbn }).first else { self.needsRefreshPage?(); return }
        self.satScore = satScore
        self.needsRefreshPage?()
    }
    
    func numberOfRows() -> Int {
        return DetailsViewCellType.allCases.count
    }
    
    func cellIdentifier(index: Int) -> String? {
        guard let cellType = DetailsViewCellType(rawValue: index) else { return nil }
        return cellType.cellIdentifier
    }
    
    func getScoresData() -> ScoresCellViewModel {
        return ScoresCellViewModel(score: satScore, schoolName: schoolData.school_name)
    }
    
    func getContactDetails() -> ContactCellViewModel {
        return ContactCellViewModel(school: schoolData)
    }
    
    func tableViewCell(_ tableView: UITableView, index: Int) -> UITableViewCell {
        guard let cellType = DetailsViewCellType(rawValue: index) else { return UITableViewCell() }
        switch cellType {
        case .score:
            guard let scoreCell = tableView.dequeueReusableCell(withIdentifier: cellType.cellIdentifier) as? ScoresCell else { return UITableViewCell() }
            let score = getScoresData()
            scoreCell.nameLabel.text = score.name
            scoreCell.satReadingAvgScoreLabel.text = score.reading
            scoreCell.satWritingAvgScoreLabel.text = score.writing
            scoreCell.satMathAvgScoreLabel.text = score.math
            return scoreCell
        case .overview:
            guard let overview = tableView.dequeueReusableCell(withIdentifier: cellType.cellIdentifier) as? OverviewCell else { return UITableViewCell() }
            overview.hsOverviewLabel.text = schoolData.overview_paragraph
            return overview
        case .contact:
            guard let contactCell = tableView.dequeueReusableCell(withIdentifier: cellType.cellIdentifier) as? ContactCell else { return UITableViewCell() }
            let contact = getContactDetails()
            contactCell.addressLabel.text = contact.address
            contactCell.phoneLabel.text = contact.phoneNumber
            contactCell.websiteLabel.text = contact.website
            return contactCell
        }
    }
    
}

struct ScoresCellViewModel {
    
    let name: String
    let reading: String
    let math: String
    let writing: String
    
    init(score: SatScore?, schoolName: String) {
        name = schoolName
        
        if let readingScr = score?.sat_critical_reading_avg_score {
            reading = "Reading average score: \(readingScr)"
        } else {
            reading = "No reading score available"
        }
        
        if let writinScr = score?.sat_writing_avg_score {
            writing = "Writing average score: \(writinScr)"
        } else {
            writing = "No writing score available"
        }
        
        if let mathScr = score?.sat_math_avg_score {
            math = "Math average score: \(mathScr)"
        } else {
            math = "No math score available"
        }
    }
}

struct ContactCellViewModel {
    
    let website: String
    var address: String?
    let phoneNumber: String?
    init(school: NYCSchool) {
        website = school.website ?? ""
        if let first = school.primary_address_line_1, let city = school.city, let state = school.state_code, let zip = school.zip {
            address = "\(first), \(city), \(state), \(zip)"
        }
        self.phoneNumber = school.phone_number ?? ""
    }
}
