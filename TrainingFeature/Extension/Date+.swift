//
//  Date+.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/24.
//

import Foundation

extension Date {
    func dateFormatter() -> String {
        let DateFormatter = DateFormatter()
        DateFormatter.dateFormat = "HH:mm"
        let timeString = DateFormatter.string(from: self)
        return timeString
    }
}
