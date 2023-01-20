//
//  Country.swift
//  Saxlshi CountriesAPi
//
//  Created by Giorgi Goginashvili on 1/20/23.
//

import Foundation

struct Country: Codable {
    let name: Name
    let flags: Flags
}

struct Name: Codable {
    let common: String?
    let official: String?
}

struct Flags: Codable {
    let png: String?
    let svg: String?
}
