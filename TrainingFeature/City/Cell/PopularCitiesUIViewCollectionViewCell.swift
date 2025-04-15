//
//  PopularCitiesUIViewCollectionViewCell.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/26.
//

import UIKit

class PopularCitiesUIViewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityImage: UIImageView!
    
    func configura(with data: ModuleItem) {
        self.layer.cornerRadius = 4
        let url = URL(string: data.Pic_Url)
        self.cityName.text = data.Item_Text
        self.cityImage.loadImage(url: url, placeholder: UIImage(named: "Hello"))
        setupGradientLayer()
    }
}

extension PopularCitiesUIViewCollectionViewCell {
    
    private func setupGradientLayer() {
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = cityImage.frame
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.init(hue: 0.0, saturation: 0.0, brightness: 0.0, alpha: 0.4).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        cityImage.layer.insertSublayer(gradientLayer, at: 0)
    }
}
