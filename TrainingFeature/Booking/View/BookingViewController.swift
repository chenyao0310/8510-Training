//
//  BookingViewController.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/17.
//

import UIKit

class BookingViewController: UIViewController {
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var group: NoCareTextField!
    @IBOutlet weak var mainTableView: UITableView!
    
    let viewModel: BookingViewModel = .shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension BookingViewController {
    
// MARK: - UI
    
    private func setupUI() {
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        self.title = "訂房"
        
        let configuration = UIImage.SymbolConfiguration(paletteColors: [.purple])
        let image = UIImage(systemName: "heart", withConfiguration: configuration)!
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.purple]
        
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: nil)
    }

    private func showSheet() {
        let sheetViewController = SheetViewController().createSheet()
        sheetViewController.delegate = self
        guard let sheet = sheetViewController.sheetPresentationController else { return }
        sheet.detents = [.custom {_ in 300 }]
        present(sheetViewController, animated: true)
    }
    
// MARK: - TableView
    
    private func setupTableView() {
        mainTableView.register(UINib(nibName: "ColaCoinTableViewCell",bundle: nil), forCellReuseIdentifier: "ColaCoinTableViewCell")
        mainTableView.register(UINib(nibName: "CityTableViewCell", bundle: nil), forCellReuseIdentifier: "CityTableViewCell")
        mainTableView.register(UINib(nibName: "DateTableViewCell", bundle: nil), forCellReuseIdentifier: "DateTableViewCell")
        mainTableView.register(UINib(nibName: "PersonTableViewCell", bundle: nil), forCellReuseIdentifier: "PersonTableViewCell")
        mainTableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        mainTableView.register(UINib(nibName: "ModuleListTableViewCell", bundle: nil), forCellReuseIdentifier: "ModuleListTableViewCell")
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.allowsSelection = false
    }
    
// MARK: - Action
    
    @objc private func personDidTab() {
        showSheet()
    }
    
    @objc private func cityDidTap() {
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .purple
        navigationController?.pushViewController(CityViewController(), animated: true)
    }
}

// MARK: - BookingViewControllerdelegate

protocol BookingViewControllerdelegate: AnyObject {
   func updatePersons()
}

extension BookingViewController: BookingViewControllerdelegate {
    func updatePersons() {
        viewModel.updatePerson()
    }
}

// MARK: - UITableViewDelegate

extension BookingViewController: UITableViewDelegate { }

extension BookingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let ModuleIndexPath = 5
        
        switch indexPath.row{
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ColaCoinTableViewCell",for: indexPath) as? ColaCoinTableViewCell {
                cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as? CityTableViewCell {
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cityDidTap))
                
                cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
                cell.city.isUserInteractionEnabled = true
                cell.city.addGestureRecognizer(tapGesture)
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "DateTableViewCell", for: indexPath) as? DateTableViewCell {
                cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
                return cell
            }
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PersonTableViewCell", for: indexPath) as? PersonTableViewCell{
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(personDidTab))
                
                cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.width + 100, bottom: 0, right: 0)
                cell.persons.isUserInteractionEnabled = true
                cell.persons.addGestureRecognizer(tapGesture)
                
                viewModel.personDidChange = { persons in
                    cell.persons.text! = persons
                }
                return cell
            }
        case 4:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell {
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                return cell
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ModuleListTableViewCell", for: indexPath) as? ModuleListTableViewCell {
                cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.width + 100, bottom: 0, right: 0)
                cell.configure(viewModel.data.first!, index: indexPath.row - ModuleIndexPath)
                return cell
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 120
        case 1...3:
            return 80
        case 4:
            return 60
        default:
            return 240
        }
    }
}

