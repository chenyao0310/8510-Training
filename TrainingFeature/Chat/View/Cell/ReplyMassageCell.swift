//
//  ReplyMassageCell.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/19.
//

import UIKit

class ReplyMassageCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var massage: UILabel!
    @IBOutlet weak var sticker: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    
    func configure(user:String, userImage:String, time:String, isUseSticker:Bool, massage:String, sticker:String) {
           userName.text = user
           self.userImage.image = UIImage(systemName: userImage)
           self.time.text = time
        
        if isUseSticker {
            self.massage.isHidden = true
            self.sticker.isHidden = false
            self.sticker.image = UIImage(named: sticker)
            self.massage.text = ""
        } else {
            self.sticker.isHidden = true
            self.massage.isHidden = false
            self.massage.text = massage
            self.sticker.image = nil
        }
    }
}


