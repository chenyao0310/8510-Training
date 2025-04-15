//
//  MemberView.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/2.
//

import UIKit

class MemberView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension MemberView {
    private func setupView() {
        let view = Bundle.main.loadNibNamed("MemberView", owner: self, options: nil)?.first as! UIView
        
        self.contentView = view
        view.bounds = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
