//
//  HotelSearchViewController.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/1.
//

import UIKit

class HotelSearchViewController: UIViewController {
    
    let viewModel: HotelSearchViewModel = .shared

    @IBOutlet weak var filter: UIButton!
    @IBOutlet weak var sorted: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let sectionHeaderHeight: CGFloat = tableView.sectionHeaderHeight
        // 設定 scrollView 頂端預設為 scetion 的高度
        // 讓 scetion 不會卡在 scrollView 頂端
        if scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y <= sectionHeaderHeight {
            scrollView.contentInset.top = -scrollView.contentOffset.y
        } else if scrollView.contentOffset.y > sectionHeaderHeight {
            scrollView.contentInset.top = -sectionHeaderHeight
        }
    }
}

extension HotelSearchViewController {
    
// MARK: - UI
    
    private func setupUI() {
        setupButton()
        setupTableView()
        navigationBar()
    }

// MARK: - Button
    
    private func setupButton() {
        filterConfigura()
    }
    
    private func filterConfigura() {
        
        
        filter.addTarget(self, action: #selector(onTouchFilter), for: .touchUpInside)
    }
    
    private func sortedConfigura() {
        sorted.addTarget(self, action: #selector(onTouchSorted), for: .touchUpInside)
    }
    
    @objc func onTouchFilter() {
        let filterViewController = FilterViewController(nibName: "FilterViewController", bundle: nil)
        let navigationContrller = UINavigationController(rootViewController: filterViewController)
        navigationContrller.modalPresentationStyle = .fullScreen
        
        self.present(navigationContrller, animated: true)
       
    }
    
    @objc func onTouchSorted() {
        
    }
    
// MARK: - Navigation
    
    private func navigationBar() {
        navigationItem.title = "花蓮市"
        navigationItem.largeTitleDisplayMode = .never
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: nil, action: nil)
        rightBarButtonItem.tintColor = .purple
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
    }
    
// MARK: - TableView
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "HotelSearchTableViewCell", bundle: nil), forCellReuseIdentifier: "HotelSearchTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
    
}

// MARK: - UITableViewDelegate

extension HotelSearchViewController: UITableViewDelegate { }


extension HotelSearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let mainLabel = UILabel()
        
        let countSting = String(viewModel.hotels?.count ?? 0)
        let fullString = "共(\(countSting))筆結果"
        let rangeOfString = (fullString as NSString).range(of: countSting)
        let attributedString = NSMutableAttributedString(string: fullString)
        attributedString.setAttributes([NSAttributedString.Key.foregroundColor: UIColor.purple], range: rangeOfString)
        mainLabel.textColor = .systemGray
        mainLabel.attributedText = attributedString
        mainLabel.font = .systemFont(ofSize: 14, weight: .regular)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainLabel)
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            mainLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -4),
            mainLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            mainLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
        
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.hotels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HotelSearchTableViewCell", for: indexPath) as? HotelSearchTableViewCell else { return UITableViewCell() }
        guard let hotel = viewModel.hotels?[indexPath.row] else { return UITableViewCell() }
        cell.configure(with: hotel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    
    
}
