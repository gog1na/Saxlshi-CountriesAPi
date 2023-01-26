//
//  CountriesViewController.swift
//  Saxlshi CountriesAPi
//
//  Created by Giorgi Goginashvili on 1/20/23.
//

import UIKit

class CountriesViewController: UIViewController, UISearchControllerDelegate {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    var apiManager: CountriesManagerProtocol = CountriesManager()
    let searchController = UISearchController(searchResultsController: nil)
    
    var countries: [Country] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchCountries()
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
    
    func fetchCountries() {
        apiManager.fetchCountries { result in
            switch result {
            case .success(let country):
                self.countries =  country
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

//MARK: - UITableViewDelegate
extension CountriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondVC = UIStoryboard(name: "CountryDetails", bundle: nil).instantiateViewController(withIdentifier: "CountryDetails") as! CountryDetailsViewController
        secondVC.countries = countries[indexPath.row]
        //secondVC.indexItem = indexPath.row BUG
        
        navigationController?.pushViewController(secondVC, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension CountriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath) as! CountryTableViewCell
        cell.configure(with: countries[indexPath.row])
        return cell
    }
}

//MARK: - UISearchResultsUpdating
extension CountriesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        print(text)
        
        if text.isEmpty {
            fetchCountries()
        } else {
            // filter = HOF -> Higher Order Function
            self.countries = self.countries.filter{$0.name.official!.lowercased().contains(text.lowercased())}
        }
        
        /* filter = HOF -> Higher Order Function
        self.countries = self.countries.filter{$0.name.official?.lowercased().contains(text.lowercased())}
         */
    }
}

