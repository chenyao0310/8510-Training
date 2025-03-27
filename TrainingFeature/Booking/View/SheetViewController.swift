//
//  SheetViewController.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/17.
//

import UIKit

class SheetViewController: UIViewController {
    
    @IBOutlet weak var adultCount: UILabel!
    @IBOutlet weak var childCount: UILabel!
    @IBOutlet weak var seniorCount: UILabel!
    @IBOutlet weak var adultPlusButton: UIButton!
    @IBOutlet weak var adultMinusButton: UIButton!
    @IBOutlet weak var childPlusButton: UIButton!
    @IBOutlet weak var childMinusButton: UIButton!
    @IBOutlet weak var seniorPlusButton: UIButton!
    @IBOutlet weak var seniorMinusButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    let viewModel: SheetViewModel = SheetViewModel()
    weak var delegate: BookingViewControllerdelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        bindingViewModel()
        setupUI()
    }
    
    func createSheet() -> SheetViewController {
        return SheetViewController(nibName: "SheetViewController", bundle: nil)
    }
}

extension SheetViewController {
    
// MARK: - BingViewModel
    
    private func bindingViewModel() {
        viewModel.adultDidChange = { [weak self] adultCount in
            self?.adultCount.text = "\(adultCount)"
        }
        viewModel.childDidChange = { [weak self] childCount in
            self?.childCount.text = "\(childCount)"
        }
        viewModel.seniorDidChange = { [weak self] seniorCount in
            self?.seniorCount.text = "\(seniorCount)"
        }
    }

// MARK: - UI
    
    private func setupUI() {
        setupLabel()
        setupButton()
    }
    
    private func setupLabel(){
        adultCount.text = viewModel.adultCount.description
        childCount.text = viewModel.childCount.description
        seniorCount.text = viewModel.seniorCount.description
    }
    
    private func setupButton() {
        adultPlusButton.addTarget(self, action: #selector(adultPlusDidTap), for: .touchUpInside)
        adultMinusButton.addTarget(self, action: #selector(adultMinusDidTap), for: .touchUpInside)
        
        childPlusButton.addTarget(self, action: #selector(childPlusDidTap), for: .touchUpInside)
        childMinusButton.addTarget(self, action: #selector(childMinusDidTap), for: .touchUpInside)
        
        seniorPlusButton.addTarget(self, action: #selector(seniorPlusDidTap), for: .touchUpInside)
        seniorMinusButton.addTarget(self, action: #selector(seniorMinusDidTap), for: .touchUpInside)
        
        confirmButton.addTarget(self, action: #selector(confirmDidTap), for: .touchUpInside)
    }

// MARK: - Action
    
   @objc private func adultPlusDidTap() {
       viewModel.addAdult()
    }
    
    @objc private func adultMinusDidTap() {
        viewModel.minusAdult()
     }
    
    @objc private func childPlusDidTap() {
        viewModel.addChild()
    }
    
    @objc private func childMinusDidTap() {
        viewModel.minusChild()
    }
    
    @objc private func seniorPlusDidTap() {
        viewModel.addSenior()
    }
    
    @objc private func seniorMinusDidTap() {
        viewModel.minusSenior()
    }
    
    @objc private func confirmDidTap() {
        viewModel.saveData()
        delegate?.updatePersons()
        self.dismiss(animated: true)
    }
}



