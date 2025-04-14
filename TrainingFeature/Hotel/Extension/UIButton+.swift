//
//  UIButton+.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/9.
//

import Foundation
import UIKit

extension UIButton {
    func loadImage(url: URL?, size: CGSize? = nil, for state: UIControl.State = .normal) {
        guard let url = url else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let data = data, let image = UIImage(data: data) {
                var finalImage = image
                
                
                if let targetSize = size {
                    let renderer = UIGraphicsImageRenderer(size: targetSize)
                    finalImage = renderer.image { _ in
                        image.draw(in: CGRect(origin: .zero, size: targetSize))
                    }
                }
            
                DispatchQueue.main.async {
                    self?.setImage(finalImage, for: state)
                }
            } else {
                print("載入圖片失效 \(error?.localizedDescription ?? "未知")")
            }
        }
        task.resume()
    }
}
