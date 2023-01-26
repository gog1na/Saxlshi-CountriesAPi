//
//  CountriesViewModel.swift
//  Saxlshi CountriesAPi
//
//  Created by Giorgi Goginashvili on 1/26/23.
//

import Foundation

protocol CountriesViewModelProtocol {
    var countries: [Country] { get }
    var onCountriesReceived: (() -> ())? { get set }
    func fetchCountries()
    func filterCountries(with text: String)
}

class CountriesViewModel: CountriesViewModelProtocol {
    //MARK: - Properties
    private var apiManager: CountriesManagerProtocol = CountriesManager()
    var onCountriesReceived: (() -> ())?  //((Void) -> (Void))?
    private(set) var countries: [Country] = [] {
        didSet {
            self.onCountriesReceived?()
            //self.tableView.reloadData()
        }
    }
    
    //MARK: - Init
    init() {}
    
    //MARK: - Methods
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
    
    func filterCountries(with text: String) {
        if text.isEmpty {
            fetchCountries()
        } else {
            // filter = HOF -> Higher Order Function
            self.countries = self.countries.filter{$0.name.official!.lowercased().contains(text.lowercased())}
            
            /* filter = HOF -> Higher Order Function
            self.countries = self.countries.filter{$0.name.official?.lowercased().contains(text.lowercased())}
             */
        }
    }
    
    
}
