//
//  SelectSortedView.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/11.
//

import UIKit

class SelectSortedView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension SelectSortedView {
    
    private func setupView() {
        let view = UINib(nibName: "SelectSortedView", bundle: Bundle(for: type(of: self))).instantiate(withOwner: self, options: nil)[0] as! UIView
        view.bounds = bounds
        view.backgroundColor = .black.withAlphaComponent(0.5)
        //        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    private func setupUI() {
        
    }
}
