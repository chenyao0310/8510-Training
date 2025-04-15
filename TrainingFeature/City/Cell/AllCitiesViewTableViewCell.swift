//
//  AllCitiesViewTableViewCell.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/26.
//

import UIKit

class AllCitiesViewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var city: UILabel!
    
    func configure(with city: String) {
        self.city.text = city
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTouchCity))
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func onTouchCity() {
        print(city.text ?? "")
    }
}

