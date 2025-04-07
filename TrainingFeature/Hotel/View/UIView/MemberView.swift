//
//  MemberView.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/2.
//

import UIKit

class MemberView: UIView {
    
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

extension MemberView {
    private func setupView() {
        let view = Bundle.main.loadNibNamed("MemberView", owner: self, options: nil)?.first as! UIView
        view.bounds = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
}
