//
//  SearchResultViewCell.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/10.
//

import UIKit

class SearchResultViewCell: UITableViewCell {

    @IBOutlet weak var result: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configura(with text: String){
        let fullString = "共(\(text))筆結果"
        let rangeOfString = (fullString as NSString).range(of: text)
        let attributedString = NSMutableAttributedString(string: fullString)
        attributedString.setAttributes([NSAttributedString.Key.foregroundColor: UIColor.purple], range: rangeOfString)
        result.textColor = .systemGray
        result.attributedText = attributedString
        result.font = .systemFont(ofSize: 14, weight: .regular)
    }
}


/*
 
 cell.configura(with: String(viewModel.hotels?.count ?? 0))
 
 
 */
