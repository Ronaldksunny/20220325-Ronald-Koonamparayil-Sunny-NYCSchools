//
//  SchoolDetailViewController.swift
//  20220325-Ronald Koonamparayil Sunny-NYCSchools
//

import UIKit

class SchoolDetailViewController: UITableViewController, ErrorDisplayable {
    
    var viewModel: SchoolDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        title = "School Details"
        setupViewModel()
        viewModel.fetchData()
    }
    
    private func setupViewModel() {
        viewModel.needsRefreshPage = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.handleError = { [weak self] error in
            self?.handleError(error)
        }
    }

    //MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.tableViewCell(tableView, index: indexPath.row)
    }
    
    //MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0,1,2:
            return UITableView.automaticDimension
        default:
            return UIScreen.main.bounds.width
        }
    }

    
}
