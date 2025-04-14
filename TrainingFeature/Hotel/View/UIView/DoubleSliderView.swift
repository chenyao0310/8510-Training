//
//  DoubleSliderView.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/8.
//

import UIKit

class DoubleSliderView: UIView {
    
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var betweenLine: UIView!
    @IBOutlet weak var maxCircle: UIButton!
    @IBOutlet weak var minCircle: UIButton!
    @IBOutlet weak var maxCircleXConstraint: NSLayoutConstraint! // 存 X 軸位置就好
    @IBOutlet weak var minCircleXConstraint: NSLayoutConstraint!
    
    var lowPrice: Decimal = 0
    var highPrice: Decimal = 0

    var maxPriceDidChange: ((Int) -> Void)?
    var minPriceDidChange: ((Int) -> Void)?
    
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

extension DoubleSliderView {
    
// MARK: - View
    
    private func setupView() {
        let nib = UINib(nibName: "DoubleSliderView", bundle: Bundle(for: type(of: self)))
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else { return }
        view.bounds = bounds
        addSubview(view)
    }
    
// MARK: - UI
    
    private func setupUI() {
        setupLine()
        setupButton()
    }
    
// MARK: - Line
    
    private func setupLine() {
        line.layer.cornerRadius = 4
        line.isUserInteractionEnabled = false
//        line.layer.shadowColor = UIColor.black.cgColor
//        line.layer.shadowOpacity = 0.1
//        line.layer.shadowOffset = .init(width: 0, height: 0)
//        line.layer.masksToBounds = false
    }
    
// MARK: - Button
    
    private func setupButton() {
        maxButtonConfigura()
        minButtonConfigura()
    }
    
    enum ButtonType {
        case min
        case max
    }
    
    private func maxButtonConfigura() {
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(maxButtonPanGesture))
        
        maxCircle.layer.shadowColor = UIColor.black.cgColor
        maxCircle.layer.shadowOpacity = 0.1
        maxCircle.layer.shadowOffset = .init(width: 1, height: 1)
        maxCircle.isUserInteractionEnabled = true
        maxCircle.addGestureRecognizer(gestureRecognizer)
    }
    
    private func minButtonConfigura() {
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(minButtonPanGesture))
        minCircle.layer.shadowColor = UIColor.black.cgColor
        minCircle.layer.shadowOpacity = 0.1
        minCircle.layer.shadowOffset = .init(width: 1, height: 1)
        minCircle.addGestureRecognizer(gestureRecognizer)
    }
    
    private func positionPrice(_ button: ButtonType) {
        if button == .max {
            let buttonPosition = maxCircleXConstraint.constant // 按鈕位置
            let betweenPrice: Decimal = highPrice - lowPrice // 價錢區間
            let long = line.frame.width - 20 // 減掉球兩個的半徑
            let percentage = Decimal(buttonPosition / long) // 百分比
            //        print(persent * betweenPrice)
            let string = (percentage * betweenPrice + highPrice).toInteger()
            self.maxPriceDidChange?(string)
        } else {
            let position = minCircleXConstraint.constant // 按鈕位置
            let betweenPrice: Decimal = highPrice - lowPrice // 價錢區間
            let long = line.frame.width - 20 // 減掉球兩個的半徑
            let percentage = Decimal(position / long) // 百分比
            let string = (betweenPrice * percentage + lowPrice).toInteger()
            self.minPriceDidChange?(string)
        }
    }
    
// MARK: - Action
    
    @objc private func maxButtonPanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: line)
        
        let maxX = max(0, -(line.frame.maxX) + minCircleXConstraint.constant + 20)
        let minX = min(0, -(line.frame.maxX) + minCircleXConstraint.constant + 20)
        
        maxCircleXConstraint.constant += translation.x
        maxCircleXConstraint.constant = maxCircleXConstraint.constant > maxX ? maxX : maxCircleXConstraint.constant
        maxCircleXConstraint.constant = maxCircleXConstraint.constant < minX ? minX : maxCircleXConstraint.constant
        
        gestureRecognizer.setTranslation(.zero, in: line)
        positionPrice(.max)
        self.layoutIfNeeded()
    }
    
    @objc private func minButtonPanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: line)
        
        let maxX = max(line.frame.maxX + maxCircleXConstraint.constant - 20, 0)
        let minX = min(line.frame.maxX + maxCircleXConstraint.constant - 20, 0)

        minCircleXConstraint.constant += translation.x
        minCircleXConstraint.constant = minCircleXConstraint.constant < minX ? minX : minCircleXConstraint.constant
        minCircleXConstraint.constant = minCircleXConstraint.constant > maxX ? maxX : minCircleXConstraint.constant
        
        gestureRecognizer.setTranslation(.zero, in: line)
        positionPrice(.min)
        self.layoutIfNeeded()
    }
    
}


