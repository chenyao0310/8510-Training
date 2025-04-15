//
//  PopularCitiesViewModel.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/28.
//

import Foundation

class PopularCitiesViewModel {
    
    static let shared: PopularCitiesViewModel = PopularCitiesViewModel()
    
    var popCitys: [ModuleItem]?
    
    private let manager: CityAPIManager = .shared
    
    private init(){
        self.popCitys = manager.fetchPopCity()
    }
}

