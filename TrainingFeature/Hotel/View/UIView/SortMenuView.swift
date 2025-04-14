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
    
    private func setupView() {
        //    let nib = UINib(nibName: "SortedView", bundle: Bundle(for: type(of: self)))
        //    guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        //    view.backgroundColor = .black.withAlphaComponent(0.5)
        //    view.bounds = bounds
        //    addSubview(view)
        //    NSLayoutConstraint.activate([
        //        view.topAnchor.constraint(equalTo: self.topAnchor),
        //        view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        //        view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        //        view.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        //    ])
        Bundle.main.loadNibNamed("SortMenuView", owner: self, options: nil)
        contentView.backgroundColor = .black.withAlphaComponent(0.5)
        addSubview(contentView)
        //    contentView.bounds = self.bounds
        //    contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissSelf))
        contentView.addGestureRecognizer(tap)
        
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
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
        highPriceFirst.isUserInteractionEnabled = true
        highPriceFirst.textColor = viewModel.sortType == .highPriceFirst ? .purple : .label
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTouchighPriceFirst))
        highPriceFirst.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func dismissSelf() {
        self.removeFromSuperview()
    }
    
    @objc private func onTouchlowPriceFirst() {
        delegate?.sortMenuDismiss()
        self.removeFromSuperview()
        if viewModel.sortType != .lowPriceFirst {
            viewModel.sortType = .lowPriceFirst
            viewModel.updateSortType(.lowPriceFirst)
            lowPriceFirst.textColor = viewModel.sortType == .lowPriceFirst ? .purple : .label
        } else {
            viewModel.sortType = .defaultSort
            viewModel.updateSortType(.defaultSort)
        }
    }
    
    @objc private func onTouchighPriceFirst() {
        delegate?.sortMenuDismiss()
        self.removeFromSuperview()
        if viewModel.sortType != .highPriceFirst{
            viewModel.sortType = .highPriceFirst
            viewModel.updateSortType(.highPriceFirst)
        } else {
            viewModel.sortType = .defaultSort
            viewModel.updateSortType(.defaultSort)
        }
    }
    
    
}
