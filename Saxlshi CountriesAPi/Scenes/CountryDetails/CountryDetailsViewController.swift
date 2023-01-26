//
//  CountryDetailsViewController.swift
//  Saxlshi CountriesAPi
//
//  Created by Giorgi Goginashvili on 1/20/23.
//

import UIKit
import Kingfisher

class CountryDetailsViewController: UIViewController {
    
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    
    var countries: Country?
    //var indexItem: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        flagImage.kf.indicatorType = .activity
        flagImage.kf.setImage(with: URL(string: countries?.flags.png ?? ""))
        textLabel.text = countries?.name.official
        //capitalLabel.text = countries?.capital![0]
    }

}
