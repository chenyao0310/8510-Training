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
        view.backgroundColor = .quaternarySystemFill
        
        var imageString = data.Item_Text
        let url = URL(string: data.Pic_Url)
        self.title.text = data.Item_Text
        self.price.text = "$\(data.Item_Price)"
        
        if data.Item_Text == "花見北陸、雪壁傳奇5日4/16~4/26"{
            // Assets 會吃掉斜線
            imageString = "花見北陸、雪壁傳奇5日416~426"
        }
        self.image.loadImage(url: url, placeholder: UIImage(named: imageString) ?? nil)
    }
}
