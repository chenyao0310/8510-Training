//
//  HotView.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/1.
//

import UIKit

class HotView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension HotView {
    
    private func setupView() {
        let view = UINib(nibName: "HotView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        view.bounds = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        view.layer.opacity = 0.5
        view.layer.cornerRadius = 4
        addSubview(view)
    
    }
}
