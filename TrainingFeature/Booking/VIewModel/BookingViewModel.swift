//
//  BookingViewModel.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/25.
//

import Foundation

class BookingViewModel {
    
    static let shared: BookingViewModel = BookingViewModel()
    
    var adultCount: Int = 0
    var childCount: Int = 0
    var seniorCount: Int = 0
    
    var personDidChange: ((String) -> Void)?
    var data: Response?
    
    private let apiService = APIManager()
    private var totalPerson: String {
        return "\(adultCount)位大人 \(childCount)位小孩 \(seniorCount)位長者"
    }
    
    init(){
        self.data = apiService.getModuleList()
    }
    
    func updatePerson() {
        personDidChange?(totalPerson)
    }
    
    func save(adult: Int, child: Int, senior: Int) {
            adultCount = adult
            childCount = child
            seniorCount = senior
        }
}

extension BookingViewModel {
    
    private func getPerson() -> String{
        return "\(adultCount)位大人 \(childCount)位小孩 \(seniorCount)位長者"
    }
}
