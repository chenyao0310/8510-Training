//
//  OverAllView.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/2.
//

import UIKit

class OverAllView: UIView {
    
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
        let view = UINib(nibName: "OverAllView", bundle: Bundle(for: type(of: self))).instantiate(withOwner: self, options: nil)[0] as! UIView
        view.bounds = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.layer.cornerRadius = 5
        addSubview(view)
    }
}
