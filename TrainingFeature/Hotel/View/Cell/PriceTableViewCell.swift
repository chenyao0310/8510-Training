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
        
        if lowPrice == nil && highPrice == nil {
            lowPrice = viewModel.lowestPrice ?? 0
            highPrice = viewModel.highestPrice ?? 0
        }
        
        // 顯示
        setupMaxAndMinPrice(min: !isRefresh ? viewModel.lowestPrice ?? 0 : viewModel.defaultLowestPrice ?? 0,
                            max: !isRefresh ? viewModel.highestPrice ?? 0 : viewModel.defaultHighestPrice ?? 0)
        
        //位置
        price.maxCircleXConstraint.constant = !isRefresh ? viewModel.highestPosition ?? 0 : viewModel.defaultHighestPosition ?? 0
        price.minCircleXConstraint.constant = !isRefresh ? viewModel.LowestPosition ?? 0 : viewModel.defaultLowestPosition ?? 0
        // 左右邊
        price.lowPrice = Decimal(Double(viewModel.defaultRange().min))
        price.highPrice = Decimal(Double(viewModel.defaultRange().max))
        
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
        viewModel.confirmDidTap = {
            if viewModel.isRefresh {
                viewModel.defaultFilter()
            } else {
                viewModel.lowestPrice = self.lowPrice
                viewModel.highestPrice = self.highPrice
                viewModel.changeRange(min: self.price.minCircleXConstraint.constant,
                                      max: self.price.maxCircleXConstraint.constant)
            }
            print("lowPrice: \(viewModel.lowestPrice ?? 0), highPrice: \(viewModel.highestPrice ?? 0)")
        }
    }
}

extension PriceTableViewCell {
    
    private func setupMaxAndMinPrice(min: Int, max: Int){
        minPrice.text = "$\(min.formatted(.number))"
        maxPrice.text = "$\(max.formatted(.number))"
    }
    
    
}


