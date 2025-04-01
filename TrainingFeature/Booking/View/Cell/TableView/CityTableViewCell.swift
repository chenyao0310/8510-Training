//
//  CityTableViewCell.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/24.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var city: UILabel!
    
    func configure(with city: String) {
        self.city.text = city
    }
}
