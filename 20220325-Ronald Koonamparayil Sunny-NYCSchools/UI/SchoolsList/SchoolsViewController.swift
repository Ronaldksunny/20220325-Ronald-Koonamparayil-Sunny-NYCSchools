//
//  SchoolsViewController.swift
//  20220325-Ronald Koonamparayil Sunny-NYCSchools
//

import UIKit
import MapKit

class SchoolsViewController: UIViewController, UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate, UISearchControllerDelegate, SchoolListCellDelegate, ErrorDisplayable {

    @IBOutlet var tableView: UITableView!
    
    var viewModel: SchoolListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        setupViewModel()
    }
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchData()
    }
    
    //MARK:- Private
    
    func setupViewModel() {
        viewModel = SchoolListViewModel()
        viewModel.needsRefreshPage = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.handleError = { [weak self] error in
            self?.handleError(error)
        }
    }
    
    func setupSearchController(){
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Schools"
        searchController.searchBar.tintColor = UIColor.white
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    //MARK:- IBAction
    
    @IBAction func reloadAction(_ sender: Any) {
        viewModel.fetchData()
    }
    
    // MARK: - UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.isFiltering = isFiltering()
        viewModel.filterContentForSearchText(searchController.searchBar.text!)
    }
    
    // MARK: - UISearchControllerDelegate
    
    func didDismissSearchController(_ searchController: UISearchController) {
        viewModel.isFiltering = isFiltering()
    }
    
    //MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SchoolListCell = self.tableView.dequeueReusableCell(withIdentifier: "SchoolListCell", for: indexPath) as! SchoolListCell

        let school: SchoolListCellViewModel = viewModel.cellDataForIndex(index: indexPath.row)
        cell.schoolNameLabel.text = school.name
        cell.schoolAddrLabel.text = school.address
        cell.schoolPhoneNumButton.setTitle(school.phoneNumber, for: .normal)
        cell.delegate = self
        cell.index = indexPath.row
        return cell
    }
    
    //MARK: - SchoolListCellDelegate
    
    func didTapCall(index: Int) {
        let school: NYCSchool = viewModel.schoolDataForIndex(index: index)
        if let url = URL(string: "tel://\(String(describing: school.phone_number))"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func didTapMap(index:Int) {
        let school: NYCSchool = viewModel.schoolDataForIndex(index: index)
        if let lat = Double(school.latitude ?? ""), let long = Double(school.longitude ?? "") {
            let coordinate = CLLocationCoordinate2DMake(lat, long)
            let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
            mapItem.name = "\(school.school_name)"
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
        }
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let school: NYCSchool = viewModel.schoolDataForIndex(index: indexPath.row)
        let viewModel = SchoolDetailViewModel(schoolData: school)
        self.performSegue(withIdentifier: "showSchoolDetail", sender: viewModel)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showSchoolDetail", let destinationVC = segue.destination as? SchoolDetailViewController, let viewModel = sender as? SchoolDetailViewModel else { return }
        destinationVC.viewModel = viewModel
    }
}
