//
//  FilterViewController.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/7.
//

import UIKit

class FilterViewController: UIViewController {
    
    let viewModel: FilterViewModel = .shared

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var confirm: UIButton!
    
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

extension FilterViewController {
    private func setupUI() {
        navgationBarSetting()
        setupTableView()
        setupConfirmButton()
    }
    
    private func setupConfirmButton() {
        confirm.addTarget(self, action: #selector(onTouchConfirm), for: .touchUpInside)
    }
    
// MARK: - Navgation
    
    private func navgationBarSetting() {
        navigationItem.title = "篩選"
        navigationBarShadow()
        setupNavgaionBarItem()
    }
    
    private func navigationBarShadow() {
     
        let window = UIApplication.shared.windows.first!
        print(window.safeAreaInsets.top)
        if let navigationBar = navigationController?.navigationBar {
            let shadowView = UIView(frame: CGRect(x: 0, y: navigationBar.frame.maxY + window.safeAreaInsets.top - 5, width: UIScreen.main.bounds.width, height: 1))
            shadowView.backgroundColor = .black
            shadowView.layer.opacity = 0.1
            shadowView.layer.shadowColor = UIColor.black.cgColor
            shadowView.layer.shadowOpacity = 1
            shadowView.layer.shadowOffset = CGSize(width: 0, height: 3)
            shadowView.layer.shadowRadius = 4
            shadowView.layer.masksToBounds = false
            navigationController?.view.addSubview(shadowView)
        }
    }
    
    private func setupNavgaionBarItem() {
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(back))
        let rightBarButtonItem = UIBarButtonItem(title: "清除條件", style: .plain, target: self, action: #selector(onTouchCancel))
        leftBarButtonItem.tintColor = .purple
        rightBarButtonItem.tintColor = .purple
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
// MARK: - Action
    
    @objc private func back() {
        viewModel.isRefresh = false
        dismiss(animated: true)
    }
    
    @objc private func onTouchConfirm() { // Fix - 等待功能完成
        viewModel.confirm()
        dismiss(animated: true)
    }
    
    @objc private func onTouchCancel() {
        viewModel.clear()
        self.tableView.reloadData()
    }
    
// MARK: - TableView
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "SearchNameTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchNameTableViewCell")
        tableView.register(UINib(nibName: "PriceTableViewCell", bundle: nil), forCellReuseIdentifier: "PriceTableViewCell")
        tableView.register(UINib(nibName: "TrainTableViewCell", bundle: nil), forCellReuseIdentifier: "TrainTableViewCell")
        tableView.register(UINib(nibName: "LocationTableViewCell", bundle: nil), forCellReuseIdentifier: "LocationTableViewCell")
        tableView.register(UINib(nibName: "StarsTableViewCell", bundle: nil), forCellReuseIdentifier: "StarsTableViewCell")
        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 0
    }
    
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchNameTableViewCell") as? SearchNameTableViewCell else {
                return UITableViewCell()
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PriceTableViewCell") as? PriceTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(viewModel: viewModel, isRefresh: viewModel.isRefresh)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TrainTableViewCell") as? TrainTableViewCell else {
                return UITableViewCell()
            }
            cell.configure()
            return cell
        default:
            break
        }
        
        return UITableViewCell()
    }
    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         let headerView = UITableViewHeaderFooterView()
         headerView.backgroundColor = .clear
         var configuration = headerView.defaultContentConfiguration()
         configuration.textProperties.font = .systemFont(ofSize: 14, weight: .regular)
         
         
         switch section {
         case 0:
             configuration.text = "指定飯店名稱"
         case 1:
             configuration.text = "房價"
         case 2:
             configuration.text = "適用加購項目"
                
         default:
             configuration.text = ""
         }
        
        
        headerView.contentConfiguration = configuration
        return headerView
    }
}
