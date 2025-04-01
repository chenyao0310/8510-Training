//
//  CityViewModel.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/27.
//

import Foundation

class CityViewModel {
    
    static let shared: CityViewModel = CityViewModel()
    
    var nowPage: Int = 0
    var totalPage: Int = 2
    var pageDidChange: ((Int) -> Void)?
    
    private let manager: CityAPIManager = .shared
}
