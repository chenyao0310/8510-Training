//
//  APIManager.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/25.
//

import Foundation

class APIManager {
    
    private var moduleList: Response?
    
    init(){
        self.moduleList = fetchResultJson()
    }
    
    func getModuleList() -> Response? {
        return moduleList
    }
}

extension APIManager {
    
    private func fetchResultJson() -> Response? {
            guard let url = Bundle.main.url(forResource: "ADTrain1", withExtension: "json") else {
                fatalError("Couldnt find result in main bundle.")
            }
            do {
                let data = try Data(contentsOf: url)
                let response = try JSONDecoder().decode(Response.self, from: data)
                return response
            } catch {
                print("decode result json failed -> \(error)")
            }
        return nil
        }
}
