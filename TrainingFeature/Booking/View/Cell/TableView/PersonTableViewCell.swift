//
//  PersonTableViewCell.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/24.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var persons: UILabel!
    
    func configure(with person: String) {
        self.persons.text = person
    }
}
