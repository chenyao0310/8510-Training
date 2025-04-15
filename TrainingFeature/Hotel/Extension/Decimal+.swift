//
//  Decimal+.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/11.
//

import Foundation

extension Decimal {
    func toInteger() -> Int {
        let intValue = NSDecimalNumber(decimal: self).doubleValue.rounded()
        return Int(intValue)
    }
}
