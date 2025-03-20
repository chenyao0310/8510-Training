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
    @IBOutlet weak var userMassage: UILabel!
    @IBOutlet weak var massageImage: UIImageView!
    @IBOutlet weak var stackView: UIStackView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(user:String, userImage:String, time:String, isUseImage:Bool, massage:String, image:String) {
           userName.text = user
           self.userImage.image = UIImage(systemName: userImage)
           self.time.text = time
        
        if isUseImage {
            self.userMassage.isHidden = true
            self.massageImage.isHidden = false
            self.massageImage.image = UIImage(named: image)
            self.userMassage.text = ""
        } else {
            self.massageImage.isHidden = true
            self.userMassage.isHidden = false
            self.userMassage.text = massage
            self.massageImage.image = nil
        }
    }
}


