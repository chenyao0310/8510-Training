//
//  MassageSendTableViewCell.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/20.
//

import UIKit

class MassageSendTableViewCell: UITableViewCell {
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var massage: UILabel!
    @IBOutlet weak var massageImage: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(time:String, isUseImage:Bool, massage:String, image:String) {
        self.time.text = time
        
        if isUseImage {
            self.massage.isHidden = true
            self.massageImage.isHidden = false
            self.massageImage.image = UIImage(named: image)
            self.massage.text = ""
        } else {
            self.massageImage.isHidden = true
            self.massage.isHidden = false
            self.massage.text = massage
            self.massageImage.image = nil
        }
    }
}

