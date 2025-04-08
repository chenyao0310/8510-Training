//
//  CityViewController.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/26.
//

import UIKit

class CityViewController: UIViewController {

    @IBOutlet weak var popularCities: UIButton!
    @IBOutlet weak var allCities: UIButton!
    @IBOutlet weak var speratorLine: UIView!
    @IBOutlet weak var speratorLineWidth: NSLayoutConstraint!
    @IBOutlet weak var speratorLeading: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var cityButtonArray: [UIButton] = []
    
    private let viewModel: CityViewModel = .shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupUI()
        bindViewModel()
    }
}

extension CityViewController {
    
// MARK: - Binding
    
    private func bindViewModel() {
        viewModel.pageDidChange = { page in
            UIView.animate(withDuration: 0.2) {
                self.popularCities.tintColor = page == 0 ? .purple : .lightGray
                self.allCities.tintColor = page == 1 ? .purple : .lightGray
            }
        }
    }
    
// MARK: - UI
    
    private func setupUI() {
        setupButton()
        updateSperatorLineWidth()
        setupScrollView()
    }
    
    private func updateSperatorLineWidth() {
        let screenSize = UIScreen.main.bounds
        let width: CGFloat = screenSize.width / CGFloat(cityButtonArray.count)
        speratorLineWidth.constant = width
    }
    
// MARK: - Button
    
    private func setupButton() {
        cityButtonArray = [popularCities, allCities]
        popularCitiesConfigura()
        allCitiesConfigura()
    }
    
    private func popularCitiesConfigura() {
        popularCities.tintColor = viewModel.nowPage == 0 ? .purple : .lightGray
        popularCities.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        popularCities.addTarget(self, action: #selector(onTouchpopularCitiesButton), for: .touchUpInside)
    }
    
    private func allCitiesConfigura() {
        allCities.tintColor = viewModel.nowPage == 1 ? .purple : .lightGray
        allCities.addTarget(self, action: #selector(onTouchallCitiesButton), for: .touchUpInside)
    }
    
    private func bottonFontChange() {
        let fouseFont: UIFont = .boldSystemFont(ofSize: 14)
        let unFocusFont: UIFont = .systemFont(ofSize: 14)
        popularCities.titleLabel?.font = viewModel.nowPage == 0 ? fouseFont : unFocusFont
        allCities.titleLabel?.font = viewModel.nowPage == 1 ? fouseFont : unFocusFont
    }
    
// MARK: - ScrollView
    
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        setupSubviews()
    }
    
    private func setupSubviews() {
        let popularCitiesView = PopularCitiesView(frame: scrollView.bounds)
        popularCitiesView.delegate = self
        let allCitiesView = AllCitiesView(frame: scrollView.bounds)
        let subViews = [popularCitiesView, allCitiesView]
        let firstView = popularCitiesView
        for view in subViews {
            view.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(view)
            subviewConstraintConfigura(with: view)
            
            if firstView == view {
                view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            } else {
                view.leadingAnchor.constraint(equalTo: firstView.trailingAnchor).isActive = true
                view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
            }
        }
    }
    
    private func subviewConstraintConfigura(with view: UIView) {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            view.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            view.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }
    
    private func scrollToThePage(at page: Int) {
        let totalPage = self.viewModel.totalPage
        var frame = self.scrollView.frame // 393
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        
        UIView.animate(withDuration: 0.1) {
            self.speratorLeading.constant = self.scrollView.contentOffset.x / CGFloat(totalPage)
            self.bottonFontChange()
            self.view.layoutIfNeeded()
        }
        
        self.viewModel.nowPage = page
        self.scrollView.scrollRectToVisible(frame, animated: true)
    }

// MARK: - Navigation
    
    private func setupNavigation() {
        setupNavigationItem()
        setupSearchBar()
    }
    
    private func setupNavigationItem() {
        let configuration = UIImage.SymbolConfiguration(paletteColors: [.purple])
        let image = UIImage(systemName: "cart", withConfiguration: configuration)!
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.purple]
        
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: nil)
    }
    
    private func setupSearchBar() {
        let searchBar = UISearchBar()
        setupSearchBarTextField(searchBar)
        navigationItem.titleView = searchBar
    }
    
    private func setupSearchBarTextField(_ searchBar: UISearchBar) {
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            let buttonLine = CALayer()
            buttonLine.frame = CGRect(x: 0, y: textField.frame.height - 1, width: textField.frame.width, height: 1)
            textField.borderStyle = .none
            textField.backgroundColor = .systemGray6
            textField.leftView = setupLeftView()
            textField.placeholder = "搜尋國家 / 城市 / 票券"
            textField.layer.borderWidth = 0.1
            textField.layer.cornerRadius = 21
            textField.layer.masksToBounds = true
            textField.layer.addSublayer(buttonLine)
        }
    }
    
     private func setupLeftView() -> UIView {
        let iconSize: CGFloat = 20
        let iconImageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        iconImageView.tintColor = .purple
        iconImageView.frame = CGRect(x: 0, y: 0, width: iconSize + 5, height: iconSize + 5)
        iconImageView.contentMode = .scaleAspectFit
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: iconSize + 5, height: iconSize + 5))
        containerView.addSubview(iconImageView)
        
        return containerView
    }

// MARK: - Action
    
    @objc private func onTouchpopularCitiesButton() {
        scrollToThePage(at: 0)
    }
    
    @objc private func onTouchallCitiesButton() {
        scrollToThePage(at: 1)
    }
}

// MARK: - UIScrollViewDelegate

extension CityViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let totalPage = viewModel.totalPage
        let currentPage = scrollView.contentOffset.x >= self.view.frame.width / CGFloat(totalPage) ? 1 : 0
        let nowOffsetX = scrollView.contentOffset.x
        
        UIView.animate(withDuration: 0.2) {
            self.speratorLeading.constant = nowOffsetX / CGFloat(totalPage)
            self.viewModel.pageDidChange?(currentPage)
            self.bottonFontChange()
            self.view.layoutIfNeeded()
        }
    }
}

protocol CityViewControllerDelegate: AnyObject {
    func pageDidChange()
}

extension CityViewController: CityViewControllerDelegate {
    func pageDidChange() {
        scrollToThePage(at: 1)
    }
}
