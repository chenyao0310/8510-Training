//
//  UIImageView+.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/25.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadImage(url: URL?, placeholder: UIImage? = nil) {
        self.image = placeholder
        guard let url = url else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            } else {
                print("載入圖片失效 \(error?.localizedDescription ?? "未知")")
            }
        }
        task.resume()
    }
}
