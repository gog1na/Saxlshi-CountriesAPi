//
//  CountriesViewController.swift
//  Saxlshi CountriesAPi
//
//  Created by Giorgi Goginashvili on 1/20/23.
//

import UIKit

/*
 MVC - Model View Controller (Massive View Controller)
 
 Model - Country
 View - Scene
 Controller - CountriesViewController
 
 ---------------------------------------
 
 MVVM - Mode View ViewModel
 
 Model - Country
 View - Scene
 ViewModel - CountriesViewController Logics
 */

class CountriesViewController: UIViewController, UISearchControllerDelegate {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    private var viewModel: CountriesViewModelProtocol = CountriesViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    
        
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        //fetchCountries()
        setupViewModel()
        setupNavBar()
    }

    //MARK: - Methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CountryTableViewCell",
                                 bundle: nil),
                           forCellReuseIdentifier: "CountryTableViewCell")
    }
    
    private func setupNavBar() {
        title = "Search"
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.delegate = self
    }
    
    private func setupViewModel() {
        viewModel.fetchCountries()
        viewModel.onCountriesReceived = {
            self.tableView.reloadData()
        }
    }

}

//MARK: - UITableViewDelegate
extension CountriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondVC = UIStoryboard(name: "CountryDetails", bundle: nil).instantiateViewController(withIdentifier: "CountryDetails") as! CountryDetailsViewController
        secondVC.countries = viewModel.countries[indexPath.row]
        //secondVC.indexItem = indexPath.row BUG
        
        navigationController?.pushViewController(secondVC, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension CountriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.countries.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath) as! CountryTableViewCell
        cell.configure(with: viewModel.countries[indexPath.row])
        return cell
    }
}

//MARK: - UISearchResultsUpdating
extension CountriesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        
        viewModel.filterCountries(with: text)
        
        
        /* filter = HOF -> Higher Order Function
        self.countries = self.countries.filter{$0.name.official?.lowercased().contains(text.lowercased())}
         */
    }
}

