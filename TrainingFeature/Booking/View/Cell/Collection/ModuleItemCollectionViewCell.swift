//
//  ModuleItemCollectionViewCell.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/24.
//

import UIKit

class ModuleItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    
    func configure(_ data: ModuleItem_List) {
        setupShadow()
        view.backgroundColor = .white
        view.layer.cornerRadius = 4
    
        let url = URL(string: data.Pic_Url)
        self.title.text = data.Item_Text
        self.price.text = "$\(data.Item_Price.formatted(.number))"
        self.image.loadImage(url: url, placeholder: UIImage(named: "Hello") ?? nil)
    }
}

extension ModuleItemCollectionViewCell {
    
    private func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 1, height: 0)
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        layer.backgroundColor = UIColor.clear.cgColor
        layer.masksToBounds = false
    }
}
