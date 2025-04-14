//
//  TrainTableViewCell.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/7.
//

import UIKit

class TrainTableViewCell: UITableViewCell {

    @IBOutlet weak var trainView: TrainView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure() {
        awakeFromNib()
    }
    
}

extension TrainTableViewCell {

    
    private func setupView() {
        
    }
}
