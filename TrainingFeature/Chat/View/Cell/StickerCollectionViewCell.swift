//
//  StickerCollectionViewCell.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/20.
//

import UIKit

class StickerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sticker: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(sticker: String) {
        self.sticker.image = UIImage(named: sticker)
    }
}
