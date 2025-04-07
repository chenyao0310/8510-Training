//
//  FilterViewController.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/7.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension FilterViewController {
    private func setupUI() {
        navgationBarSetting()
        setupTableView()
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
            let shadowView = UIView(frame: CGRect(x: 0, y: navigationBar.frame.maxY + window.safeAreaInsets.top, width: UIScreen.main.bounds.width, height: 1))
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
        let rightBarButtonItem = UIBarButtonItem(title: "清除條件", style: .plain, target: nil, action: nil)
        leftBarButtonItem.tintColor = .purple
        rightBarButtonItem.tintColor = .purple
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
// MARK: - Action
    
    @objc private func back() {
        dismiss(animated: true)
    }
    
// MARK: - TableView
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
