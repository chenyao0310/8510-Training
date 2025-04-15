//
//  AllCitiesViewModel.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/28.
//

import Foundation

class AllCitiesViewModel {
    
    static let shared = AllCitiesViewModel()
    
    var allCitys: AllCityModel?
    var isShowAllCitys: [Bool] = []
    var selectedCountryIndexDidChange: ((Int?) -> Void)?

    private let manager: CityAPIManager = .shared
    
    private init() {
        allCitys = manager.fetchAllCity()
        self.isShowAllCitys = Array(repeating: false, count: allCitys?.Country.count ?? 0)
    }
}
