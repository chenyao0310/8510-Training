//
//  CityAPIManager.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/28.
//

import Foundation

class CityAPIManager {
    
    static let shared = CityAPIManager()
    
     func fetchAllCity() -> AllCityModel? {
        guard let url = Bundle.main.url(forResource: "AllCity", withExtension: "json") else {
            fatalError("Couldnt find result in main bundle.")
        }
        do {
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode(AllCityModel.self, from: data)
            return response
        } catch {
            print("decode result json failed -> \(error)")
        }
        return nil
    }
    
     func fetchPopCity() -> [ModuleItem]? {
        guard let url = Bundle.main.url(forResource: "PopCity", withExtension: "json") else {
            fatalError("Couldnt find result in main bundle.")
        }
        do {
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode(PopCtiyModel.self, from: data)
            return response.ModuleItem
        } catch {
            print("decode result json failed -> \(error)")
        }
        return nil
    }
}
