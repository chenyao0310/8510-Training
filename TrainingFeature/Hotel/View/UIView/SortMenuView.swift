//
//  SortMenuView.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/14.
//

import UIKit

class SortMenuView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var lowPriceFirst: UILabel!
    @IBOutlet weak var highPriceFirst: UILabel!

    weak var delegate: HotelSearchViewControllerDelegate?
    
    let viewModel: SortMenuViewModel = .shared

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setupLabel()
      }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLabel()
      }


    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupLabel()
      }
    }

extension SortMenuView {
    
// MARK: - View
    
    private func setupView() {
        Bundle.main.loadNibNamed("SortMenuView", owner: self, options: nil)
        contentView.backgroundColor = .black.withAlphaComponent(0.5)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissSelf))
        contentView.addGestureRecognizer(tap)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
// MARK: - Label
    
    private func setupLabel() {
        lowPriceFirstConfigura()
        highPriceFirstConfigura()
    }
    
    private func lowPriceFirstConfigura() {
        lowPriceFirst.font = UIFont.systemFont(ofSize: 17)
        lowPriceFirst.textColor = viewModel.sortType == .lowPriceFirst ? .purple : .label
        lowPriceFirst.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTouchlowPriceFirst))
        lowPriceFirst.addGestureRecognizer(gestureRecognizer)
    }
    
    private func highPriceFirstConfigura() {
        highPriceFirst.font = UIFont.systemFont(ofSize: 17)
        highPriceFirst.textColor = viewModel.sortType == .highPriceFirst ? .purple : .label
        highPriceFirst.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTouchighPriceFirst))
        highPriceFirst.addGestureRecognizer(gestureRecognizer)
    }
    
    private func updataLabelAndState(with label: UILabel, type: HotelSearchViewModel.SortType) {
        if viewModel.sortType != type {
            viewModel.sortType = type
            viewModel.updateSortType(type)
            label.textColor = viewModel.sortType == type ? .purple : .label
        } else {
            viewModel.sortType = .defaultSort
            viewModel.updateSortType(.defaultSort)
        }
    }
    
    @objc private func dismissSelf() {
        self.removeFromSuperview()
    }
    
    @objc private func onTouchlowPriceFirst() {
        delegate?.sortMenuDismiss()
        dismissSelf()
        updataLabelAndState(with: lowPriceFirst, type: .lowPriceFirst)
    }
    
    @objc private func onTouchighPriceFirst() {
        delegate?.sortMenuDismiss()
        dismissSelf()
        updataLabelAndState(with: highPriceFirst, type: .highPriceFirst)
    }
}
