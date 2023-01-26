//
//  CountriesManager.swift
//  Saxlshi CountriesAPi
//
//  Created by Giorgi Goginashvili on 1/20/23.
//

import Foundation

protocol CountriesManagerProtocol {
    func fetchCountries(completion: @escaping (Result<[Country], Error>) -> ())
}

class CountriesManager: CountriesManagerProtocol {
    func fetchCountries(completion: @escaping (Result<[Country], Error>) -> ()) {
        NetworkManager.shared.get(url: "https://restcountries.com/v3.1/all") { (result: Result<[Country], Error>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
