//
//  PopularCitiesUIView.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/26.
//

import UIKit

class PopularCitiesView: UIView {
    
    @IBOutlet weak var checkAll: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: CityViewControllerDelegate?
    
    private let viewModel: PopularCitiesViewModel = .shared

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
}

extension PopularCitiesView {
    
    private func setupView() {
        let view = loadFormNib()
        view.frame = self.bounds
        addSubview(view)
        setupCollection()
        checkAllAction()
    }
    
    private func loadFormNib() -> UIView {
        let nib = UINib(nibName: "PopularCitiesView", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    private func setupCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "PopularCitiesUIViewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PopularCitiesUIViewCollectionViewCell")
    }
    
    private func checkAllAction() {
        checkAll.addTarget(self, action: #selector(onTouchcheckAll), for: .touchUpInside)
    }
    
    @objc private func onTouchcheckAll() {
        delegate?.pageDidChange()
    }
}

// MARK: - UICollectionViewDelegate

extension PopularCitiesView: UICollectionViewDelegateFlowLayout { }

extension PopularCitiesView: UICollectionViewDelegate { }

extension PopularCitiesView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.popCitys?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        guard let data = viewModel.popCitys?[indexPath.row] else { return cell }
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCitiesUIViewCollectionViewCell", for: indexPath) as? PopularCitiesUIViewCollectionViewCell {
            
            cell.configura(with: data)
            return cell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow: CGFloat = 3
        let cellWidthSpacing: CGFloat = 8
        let totalWidthSpacing = (numberOfItemsPerRow - 1) * cellWidthSpacing + (2 * cellWidthSpacing)
        
        return CGSize(width: (collectionView.bounds.width - totalWidthSpacing) / 3, height: (collectionView.bounds.width - totalWidthSpacing) / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = viewModel.popCitys?[indexPath.row] else { return }
        print(data.Item_Text)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}

