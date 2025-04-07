//
//  StarView.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/2.
//

import UIKit

class StarView: UIView {
    
    @IBOutlet weak var one: UIImageView!
    @IBOutlet weak var two: UIImageView!
    @IBOutlet weak var three: UIImageView!
    @IBOutlet weak var four: UIImageView!
    @IBOutlet weak var five: UIImageView!
    
    var rating: Double = 0 {
        didSet{
            updateStars()
        }
    }
    
    private var stars: [UIImageView] = []
    
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

extension StarView {
    
    private func setupView() {
        let nib = UINib(nibName: "StarView", bundle: Bundle(for: type(of: self)))
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        view.bounds = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        stars = [one, two, three, four, five]
    }
    
    private func updateStars() {
        var count = rating
        for (index, star)  in stars.enumerated(){
            star.isHidden = false
            if Int(rating) > index {
                count -= 1
                star.image = UIImage(named: "hotel_star_full")
                print(star.image ?? nil)
                print("\(Int(rating)) > \(index)")
            } else if count == 0.5 {
                count -= 0.5
                star.image = UIImage(named: "hotel_star_half")
            } else {
                star.isHidden = true
                star.image = nil
                print("Done")
            }
        }
    }
}
