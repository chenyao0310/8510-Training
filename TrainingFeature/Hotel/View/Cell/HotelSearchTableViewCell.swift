//
//  HotelSearchTableViewCell.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/1.
//

import UIKit

class HotelSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var hotelImage: UIImageView!
    @IBOutlet weak var train: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var star: StarView!
    @IBOutlet weak var hotView: UIView!
    @IBOutlet weak var member: UIView!
    @IBOutlet weak var overAll: UIView!
    @IBOutlet weak var recommend: UILabel!
    @IBOutlet weak var neight: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var starViewWidth: NSLayoutConstraint!
   
    var data: Hotel_List?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setupView()
        maincornerRadius()
        mainViewShadow()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        member.subviews.forEach { $0.removeFromSuperview() }
        hotView.subviews.forEach { $0.removeFromSuperview() }
        overAll.subviews.forEach { $0.removeFromSuperview() }
    }
    
    func configure(with data: Hotel_List) {
        self.data = data
        awakeFromNib()
    }
}


extension HotelSearchTableViewCell {
    
// MARK: - UI
    
    private func setupUI() {
        setupLabel()
        setupImage()
    }
    
// MARK: - Label
    
    private func setupLabel() {
        hotelNameConfigura()
        recommendConfigura()
        priceConfigura()
        cityConfigura()
        neightConfigura()
    }
    
    private func hotelNameConfigura() {
        guard let hotelName = data?.Hotel_Name else { return }
        self.hotelName.text = hotelName
    }
    
    private func recommendConfigura() {
        guard let recommed = data?.Recommendation else { return }
        self.recommend.text = recommed
    }
    
    private func priceConfigura() {
        guard let price = data?.TWD_RetailPrice_Value else { return }
        self.price.text = "$\(String(price))"
    }
    
    private func cityConfigura() {
        guard let city = data?.Location_Name else { return }
        self.city.text = city
    }
    
    private func neightConfigura() {
        guard let neight = data?.Price_Prefix else { return }
        self.neight.text = neight
    }
    
// MARK: - Image
    
    private func setupImage() {
        hotelImageConfigura()
        trainConfigura()
    }
    
    private func hotelImageConfigura() {
        guard let image = data?.Img_Url else { return }
        hotelImage.loadImage(url: URL(string: image))
        hotelImage.layer.cornerRadius = 4
    }
    
    private func trainConfigura() {
        guard let url = data?.Add_On?.first else {
            train.image = nil
            return
        }
        train.loadImage(url: URL(string: url))
    }
    
// MARK: - View
    
    private func setupView() {
        setupHotView()
        setupOverAllView()
        setupMemberView()
        setupStarView()
    }
    
    private func setupHotView() {
        guard let isHot = data?.Is_Hot, isHot else { return }
        let view = HotView(frame: hotView.bounds)
        view.translatesAutoresizingMaskIntoConstraints = false
        hotView.addSubview(view)
        setupConstraints(with: view, equalTo: hotView)
    }
    
    private func setupOverAllView() {
        guard let string = data?.Overall, string != "" else { return }
        let view = OverAllView(frame: overAll.bounds)
        view.configure(with: string)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        overAll.addSubview(view)
        setupConstraints(with: view, equalTo: overAll)
    }
    
    private func setupMemberView() {
        guard let memberLabel = data?.Member_Label, memberLabel != "" else { return }
        let view = MemberView(frame: member.bounds)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        member.addSubview(view)
        setupConstraints(with: view, equalTo: member)
    }
    
    private func setupStarView() {
//        star.subviews.forEach { $0.removeFromSuperview() }
//        if let constraint = dynamicStarWidthConstraint {
//            star.removeConstraint(constraint)
//        }
        guard let data else { return }
        let viewModel = data.Hotel_Grade // viewModel Data
        var starCount = viewModel // 處理 0.5 問題
        var half = false // 半星
        if starCount.truncatingRemainder(dividingBy: 1) == 0.5 { // 抓小數點後一位
            half = true
            starCount -= 0.5
        }
//        let view = StarView(frame: star.bounds)
//        view.translatesAutoresizingMaskIntoConstraints = false
//        star.addSubview(view)
        // 起始位置 * 總星星數量(包含一半) + 間距 * 星星數量(包含一半)
        starViewWidth.constant = 12 * (starCount + (half ? 1 : 0)) + 2 * (starCount - (half ? 0 : 1))
        star.rating = viewModel
//        setupConstraints(with: view, equalTo: star)
    }
    
    private func setupConstraints(with sub: UIView, equalTo main: UIView) {
        NSLayoutConstraint.activate([
            sub.topAnchor.constraint(equalTo: main.topAnchor),
            sub.bottomAnchor.constraint(equalTo: main.bottomAnchor),
            sub.leadingAnchor.constraint(equalTo: main.leadingAnchor),
            sub.trailingAnchor.constraint(equalTo: main.trailingAnchor)
        ])
    }
    
    private func maincornerRadius() {
        mainView.layer.cornerRadius = 4
        mainView.clipsToBounds = false
    }
    
    private func mainViewShadow() {
        mainView.layer.shadowOffset = CGSize(width: 1, height: 3)
        mainView.layer.shadowOpacity = 0.1
        mainView.layer.shadowRadius = 4
    }
}
