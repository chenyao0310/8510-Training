//
//  ModuleListTableViewCell.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/24.
//

import UIKit

class ModuleListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var title: UILabel!

   private var data: Module_List?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func configure(_ data: Response, index: Int){
        self.title.text = data.Module_List[index].Module_Text
        self.data = data.Module_List[index]
    }
}

extension ModuleListTableViewCell {
    
    private func setupUI() {
        setupCollection()
    }
    
    private func setupCollection() {
        let nib = UINib(nibName: "ModuleItemCollectionViewCell", bundle: nil)
        collection.register(nib, forCellWithReuseIdentifier: "ModuleItemCollectionViewCell")
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.layer.cornerRadius = 5
    }
}

// MARK: - UICollectionViewDelegate

extension ModuleListTableViewCell: UICollectionViewDelegate { }

extension ModuleListTableViewCell: UICollectionViewDelegateFlowLayout { }

extension ModuleListTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = data else { return 0 }
        return data.ModuleItem_List.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ModuleItemCollectionViewCell", for: indexPath) as? ModuleItemCollectionViewCell {
            guard let data = data else { return cell }
            cell.configure(data.ModuleItem_List[indexPath.row])
            return cell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 160)
    }
}
