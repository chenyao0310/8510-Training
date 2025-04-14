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
    @IBOutlet weak var headerView: UIView!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.dataIsChange = {
            guard let data = self.viewModel.hotels else { return }
//            let indexPath = (0...data.count).map { IndexPath(row: $0, section: 0)
//            }
//            self.tableView.reloadRows(at: indexPath, with: .automatic)
            self.tableView.reloadData()
        }
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let sectionHeaderHeight: CGFloat = tableView.sectionHeaderHeight
//        // 設定 scrollView 頂端預設為 scetion 的高度
//        // 讓 scetion 不會卡在 scrollView 頂端
//        if scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y <= sectionHeaderHeight {
//            scrollView.contentInset.top = -scrollView.contentOffset.y
//        } else if scrollView.contentOffset.y > sectionHeaderHeight {
//            scrollView.contentInset.top = -sectionHeaderHeight
//        }
//    }
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
        sortedConfigura()
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
        if let overlay = viewModel.sortedOverlay {
                // 淡出動畫並移除
                UIView.animate(withDuration: 0.25, animations: {
                    overlay.alpha = 0
                }, completion: { _ in
                    overlay.removeFromSuperview()
                    self.viewModel.sortedOverlay = nil
                })
            } else {
                let overlay = SortMenuView()
                overlay.delegate = self
                overlay.translatesAutoresizingMaskIntoConstraints = false
                overlay.alpha = 0
                self.view.addSubview(overlay)

                NSLayoutConstraint.activate([
                    overlay.topAnchor.constraint(equalTo: headerView.bottomAnchor),
                    overlay.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    overlay.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    overlay.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])

                self.viewModel.sortedOverlay = overlay

                UIView.animate(withDuration: 0.25) {
                    overlay.alpha = 1
                }
            }
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
        tableView.register(UINib(nibName: "SearchResultViewCell", bundle: nil), forCellReuseIdentifier: "SearchResultViewCell")
        tableView.register(UINib(nibName: "HotelSearchTableViewCell", bundle: nil), forCellReuseIdentifier: "HotelSearchTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.sectionHeaderTopPadding = 0
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
        let trainView = TrainView(frame: .init(x: 0, y: 0, width: 160, height: 31))
        trainView.delegate = self
        trainView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(trainView)

        NSLayoutConstraint.activate([
            trainView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            trainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            trainView.heightAnchor.constraint(equalToConstant: 31),
            trainView.widthAnchor.constraint(equalToConstant: 160),
        ])
//        
        view.backgroundColor = .white
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let hotels = viewModel.hotels?.count else { return 0 }
        return hotels + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let hotels = viewModel.hotels else { return UITableViewCell() }
        let dataIndex = indexPath.row - 1
        if indexPath.row == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultViewCell", for: indexPath) as? SearchResultViewCell else { return UITableViewCell() }
            cell.configura(with: String(hotels.count))
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HotelSearchTableViewCell", for: indexPath) as? HotelSearchTableViewCell else { return UITableViewCell() }
            cell.configure(with: hotels[dataIndex])
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 52 : 320
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 52
    }
}


protocol HotelSearchViewControllerDelegate: AnyObject {
//    func taninIsSelected()
    func train()
    func sortMenuDismiss()
}

extension HotelSearchViewController: HotelSearchViewControllerDelegate {
    func train() {
        viewModel.filterTrain()
    }
    
    func sortMenuDismiss() {
        viewModel.sortedOverlay = nil
        viewModel.hotelsSort()
    }
}
