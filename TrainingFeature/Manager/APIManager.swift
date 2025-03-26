//
//  APIManager.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/25.
//

import Foundation

class APIManager {
    
    private var moduleList: [Response] = []
    
    init(){
        fetchResultJson()
    }
    
    func getModuleList() -> [Response] {
        return moduleList
    }
}

extension APIManager {
    
    private func fetchResultJson() {
            guard let url = Bundle.main.url(forResource: "ADTrain1", withExtension: "json") else {
                fatalError("Couldnt find result in main bundle.")
            }
            do {
                let data = try Data(contentsOf: url)
                let response = try JSONDecoder().decode(Response.self, from: data)
                moduleList.append(response)
            } catch {
                print("decode result json failed -> \(error)")
            }
        }
}
