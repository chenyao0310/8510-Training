//
//  PriceTableViewCell.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/7.
//

import UIKit

class PriceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var maxPrice: UILabel!
    @IBOutlet weak var minPrice: UILabel!
    @IBOutlet weak var price: DoubleSliderView!
    
    var lowPrice: Int?
    var highPrice: Int?
    
    func configure(viewModel: FilterViewModel, isRefresh: Bool) {
        
        lowPrice = isRefresh ? viewModel.defaultLowestPrice ?? 0 : viewModel.lowestPrice ?? 0
        highPrice = isRefresh ? viewModel.defaultHighestPrice ?? 0 : viewModel.highestPrice ?? 0
        
        // 顯示
        setupMaxAndMinPrice(min: !isRefresh ? viewModel.lowestPrice ?? 0 : viewModel.defaultLowestPrice ?? 0,
                            max: !isRefresh ? viewModel.highestPrice ?? 0 : viewModel.defaultHighestPrice ?? 0)
        
        // 位置
        price.maxCircleXConstraint.constant = !isRefresh ? viewModel.highestPosition ?? 0 : viewModel.defaultHighestPosition ?? 0
        price.minCircleXConstraint.constant = !isRefresh ? viewModel.LowestPosition ?? 0 : viewModel.defaultLowestPosition ?? 0
        // 左右邊
        price.lowPrice = Decimal(Double(viewModel.defaultPriceRange().min))
        price.highPrice = Decimal(Double(viewModel.defaultPriceRange().max))
        
        // 改變
        price.maxPriceDidChange = { [weak self] price in
            self?.maxPrice.text = "$\(price.formatted(.number))"
            self?.highPrice = price
            viewModel.isRefresh = false
        }
        price.minPriceDidChange = { [weak self] price in
            self?.minPrice.text = "$\(price.formatted(.number))"
            self?.lowPrice = price
            viewModel.isRefresh = false
        }
    }
    
     func updateViewModel(_ viewModel: FilterViewModel) {
         viewModel.lowestPrice = self.lowPrice
         viewModel.highestPrice = self.highPrice
         viewModel.changeRange(min: price.minCircleXConstraint.constant,
                              max: price.maxCircleXConstraint.constant)
    }
}


extension PriceTableViewCell {
    
    private func setupMaxAndMinPrice(min: Int, max: Int){
        minPrice.text = "$\(min.formatted(.number))"
        maxPrice.text = "$\(max.formatted(.number))"
    }
}


