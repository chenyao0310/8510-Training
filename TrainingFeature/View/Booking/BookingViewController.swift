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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension BookingViewController {
    
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
        sheetViewController.delegate = self
        guard let sheet = sheetViewController.sheetPresentationController else { return }
        sheet.detents = [.custom {_ in 300 }]
        present(sheetViewController, animated: true)
    }
    
// MARK: - Action
    
     @objc private func textfieldDidTab() {
        group.text = ""
        showSheet()
    }
}

// MARK: - BookingViewControllerdelegate

protocol BookingViewControllerdelegate: AnyObject {
   func updatePersons(_ string : String)
}

extension BookingViewController: BookingViewControllerdelegate {
    func updatePersons(_ string : String) {
        group.text = string
    }
}
