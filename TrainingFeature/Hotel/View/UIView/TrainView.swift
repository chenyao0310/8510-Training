//
//  TrainView.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/10.
//

import UIKit

class TrainView: UIView {

    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var train: UIImageView!
    @IBOutlet weak var trainLabel: UILabel!
    
    let viewModel: TrainViewModel = .shared
    
    weak var delegate: HotelSearchViewControllerDelegate?
    
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
    
    deinit {
        print("Train has gone")
    }
    
}

extension TrainView {

    private func setupView() {
        let view = UINib(nibName: "TrainView", bundle: Bundle(for: type(of: self))).instantiate(withOwner: self, options: nil)[0] as! UIView
        view.bounds = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        
        setupbackgroundView()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTouchView))
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    private func setupbackgroundView() {
        backgroundView.backgroundColor = viewModel.isSelected ? UIColor(red: 243/255, green: 215/255, blue: 255, alpha: 0.8) : UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        backgroundView.layer.cornerRadius = self.bounds.height / 2.2
        backgroundView.clipsToBounds = true
    }
    
    private func setupUI() {
        setupLabel()
        setupImageView()
    }
    
    private func setupLabel() {
        trainLabel.font = viewModel.isSelected ? UIFont.boldSystemFont(ofSize: 15) : UIFont.systemFont(ofSize: 15)
    }
    
    private func setupImageView() {
        train.loadImage(url: URL(string: "https://www.colatour.com.tw/COLA_AppFiles/M03C_Hotel/thsr_train_gray@3x.png"))
    }
    
    private func updateUI(_ isSelected: Bool) {
        trainLabel.textColor = isSelected ? UIColor(red: 126/255, green: 58/255, blue: 164/255, alpha: 1) : .black
        trainLabel.font = isSelected ? UIFont.boldSystemFont(ofSize: 15) : UIFont.systemFont(ofSize: 15)
        backgroundView.backgroundColor = isSelected ? UIColor(red: 243/255, green: 215/255, blue: 255, alpha: 0.8) : UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
    }
    
   @objc private func onTouchView() {
//       guard let viewModel else { return }
       viewModel.isSelected.toggle()
       updateUI(viewModel.isSelected)
       viewModel.updateSelected()
       delegate?.train()
       
    }
}
