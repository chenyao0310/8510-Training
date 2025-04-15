//
//  CountryHeaderView.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/31.
//

import UIKit

class CountryHeaderView: UIView {
    
    @IBOutlet weak var arrowToTop: UILabel!
    @IBOutlet weak var arrowToBottom: UILabel!
    @IBOutlet weak var contry: UILabel!
    
    var data: Country?
    var section: Int = 0
    var onTouchSection: ((Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView(){
        let nib = UINib(nibName: "CountryHeaderView", bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = self.bounds
        self.addSubview(view)
        setupConstraints(view)
    }
    
    func configure(with data: Country, isSelected: Bool, section: Int) {
        self.arrowToBottom.transform = CGAffineTransform(rotationAngle: .pi)
        self.arrowToBottom.isHidden = isSelected
        self.arrowToTop.isHidden = !isSelected
        self.data = data
        self.contry.text = data.Country_Name
        self.section = section
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func handleTap() {
        onTouchSection?(section)
    }
}

extension CountryHeaderView {
    
    private func setupConstraints(_ view: UIView) {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}


