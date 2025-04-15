//
//  AllCitiesView.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/26.
//

import UIKit

class AllCitiesView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel: AllCitiesViewModel = .shared

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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let sectionHeaderHeight: CGFloat = 44
        // 設定 scrollView 頂端預設為 scetion 的高度
        // 讓 scetion 不會卡在 scrollView 頂端
        if scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y <= sectionHeaderHeight {
            scrollView.contentInset.top = -scrollView.contentOffset.y
        } else if scrollView.contentOffset.y > sectionHeaderHeight {
            scrollView.contentInset.top = -sectionHeaderHeight
        }
    }
}

extension AllCitiesView {
    
    private func setupView() {
        let view = loadFormNib()
        view.frame = self.bounds
        view.backgroundColor = .black
        addSubview(view)
        setupTableView()
    }
    
    private func loadFormNib() -> UIView {
        let nib = UINib(nibName: "AllCitiesView", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "AllCitiesViewTableViewCell", bundle: nil), forCellReuseIdentifier: "AllCitiesViewTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 0
    }
    
    private func onTouchCountry(_ section: Int) {
        viewModel.isShowAllCitys[section].toggle()
        self.tableView.reloadSections(IndexSet(integer: section), with: .fade)
    }
}

extension AllCitiesView: UITableViewDelegate { }

extension AllCitiesView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.allCitys?.Country.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let citysCount = viewModel.allCitys?.Country[section].City_List.count else { return 0 }
        return viewModel.isShowAllCitys[section] ? citysCount : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllCitiesViewTableViewCell") as? AllCitiesViewTableViewCell else {
            return UITableViewCell()
        }
        guard let data = viewModel.allCitys?.Country[indexPath.section] else { return cell }
            cell.configure(with: data.City_List[indexPath.row].City_Name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let country = viewModel.allCitys?.Country[section] else { return nil }
        let view = CountryHeaderView()
        view.configure(with: country, isSelected: viewModel.isShowAllCitys[section], section: section)
        view.onTouchSection = { [weak self] section in
            self?.onTouchCountry(section)
        }
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}

