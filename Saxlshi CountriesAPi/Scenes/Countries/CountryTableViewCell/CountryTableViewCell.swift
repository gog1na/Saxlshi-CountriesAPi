//
//  CountryTableViewCell.swift
//  Saxlshi CountriesAPi
//
//  Created by Giorgi Goginashvili on 1/20/23.
//

import UIKit
import Kingfisher

class CountryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with country: Country) {
        countryName.text = country.name.official
        flagImage.kf.indicatorType = .activity
        flagImage.kf.setImage(with: URL(string: country.flags.png ?? ""))
    }
    
}
