//
//  FilterViewController.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/7.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var confirm: UIButton!
    
    let viewModel: FilterViewModel = .shared
    
    weak var delegate: HotelSearchViewControllerDelegate?
    
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
    
// MARK: - UI
    
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
        viewModel.returnToDefault()
        dismiss(animated: true)
    }
    
    @objc private func onTouchConfirm() {
        if let indexPath = IndexPath(row: 0, section: 0) as IndexPath?,
        let priceCell = tableView.cellForRow(at: indexPath) as? PriceTableViewCell {
            priceCell.updateViewModel(viewModel)
          }
        
        viewModel.confirm()
        delegate?.changeFilterTitleColor()
        dismiss(animated: true)
    }
    
    @objc private func onTouchCancel() {
        viewModel.clear()
        self.tableView.reloadData()
    }
    
// MARK: - TableView
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "PriceTableViewCell", bundle: nil), forCellReuseIdentifier: "PriceTableViewCell")
        tableView.register(UINib(nibName: "TrainTableViewCell", bundle: nil), forCellReuseIdentifier: "TrainTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 0
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PriceTableViewCell") as? PriceTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(viewModel: viewModel, isRefresh: viewModel.isRefresh)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TrainTableViewCell") as? TrainTableViewCell else {
                return UITableViewCell()
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         let headerView = UITableViewHeaderFooterView()
         headerView.backgroundColor = .clear
         var configuration = headerView.defaultContentConfiguration()
         configuration.textProperties.font = .systemFont(ofSize: 14, weight: .regular)
         
         switch section {
         case 0:
             configuration.text = "房價"
         case 1:
             configuration.text = "適用加購項目"
                
         default:
             configuration.text = ""
         }
        
        headerView.contentConfiguration = configuration
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          switch indexPath.section {
          case 1:
              return 72
          default:
              return UITableView.automaticDimension
         }
    }
}
