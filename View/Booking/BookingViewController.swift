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
    
    var viewModel = BookingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindingViewModel()
    }
}

extension BookingViewController {
    
// MARK: - BingViewModel
    
    private func bindingViewModel() {
        viewModel.updateCount = { [weak self] string in
            self?.group.text = string
        }
    }
    
// MARK: - UI
    
    private func setupUI() {
        setupTextField()
    }
    
    private func setupTextField() {
        group.placeholder = "請選擇人數"
        group.borderStyle = .none
        group.font = UIFont.systemFont(ofSize: 20)
        group.addTarget(self, action: #selector(textfieldDidTab), for: .touchDown)
    }

    private func showSheet() {
        let sheetViewController = SheetViewController().createSheet()
        sheetViewController.viewModel = viewModel
        guard let sheet = sheetViewController.sheetPresentationController else { return }
        sheet.detents = [.custom {_ in 300 }]
        
        viewModel.clear()
        present(sheetViewController, animated: true)
    }
    
// MARK: - Action
    
     @objc private func textfieldDidTab() {
        group.text = ""
        showSheet()
    }
}
