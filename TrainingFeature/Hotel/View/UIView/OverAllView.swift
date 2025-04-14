//
//  OverAllView.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/2.
//

import UIKit

class OverAllView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var number: UILabel!
    
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
    
    func configure(with number: String) {
        self.number.text = number
    }

}

extension OverAllView {
    
    private func setupView() {
//        Bundle.main.loadNibNamed("OverAllView", owner: self, options: nil)
        let view = UINib(nibName: "OverAllView", bundle: Bundle(for: type(of: self))).instantiate(withOwner: self, options: nil)[0] as! UIView
        self.contentView = view
        view.bounds = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.layer.cornerRadius = 5
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
