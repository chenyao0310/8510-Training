//
//  BookingViewModel.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/25.
//

import Foundation

class BookingViewModel {
    
    var personDidChange: ((String) -> Void)?
    var data: [Response] = []
    
    private let apiService = APIManager()
    private let bookingManager: BookingManager = .shared
    private var totalPerson: String = ""
    
    init(){
        self.data = apiService.getModuleList()
    }
    
    func updatePerson() {
        totalPerson = bookingManager.getSting()
        personDidChange?(totalPerson)
    }
}
