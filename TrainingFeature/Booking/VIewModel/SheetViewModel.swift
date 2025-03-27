//
//  SheetViewModel.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/17.
//

import Foundation
import UIKit

class SheetViewModel {
    
    var adultCount: Int = 0
    var childCount: Int = 0
    var seniorCount: Int = 0
    
    var adultDidChange: ((Int) -> Void)?
    var childDidChange: ((Int) -> Void)?
    var seniorDidChange: ((Int) -> Void)?
    
    let bookingViewModel: BookingViewModel = .shared
    
    init() {
        getData()
    }
    
    func getData() {
        adultCount = bookingViewModel.adultCount
        childCount = bookingViewModel.childCount
        seniorCount = bookingViewModel.seniorCount
    }
    
    func saveData() {
        bookingViewModel.save(adult: adultCount, child: childCount, senior: seniorCount)
    }

    func addAdult() {
        guard adultCount < 9 else { return }
        adultCount += 1
        adultDidChange?(adultCount)
    }
    
    func minusAdult() {
        guard adultCount > 0 else { return }
        adultCount -= 1
        adultDidChange?(adultCount)
    }
    
    func addChild() {
        guard childCount < 9 else { return }
        childCount += 1
        childDidChange?(childCount)
    }
    
    func minusChild() {
        guard childCount > 0 else { return }
        childCount -= 1
        childDidChange?(childCount)
    }
    
    func addSenior() {
        guard seniorCount < 9 else { return }
        seniorCount += 1
        seniorDidChange?(seniorCount)
    }
    
    func minusSenior() {
        guard seniorCount > 0 else { return }
        seniorCount -= 1
        seniorDidChange?(seniorCount)
    }
}
