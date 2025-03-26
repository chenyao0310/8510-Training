//
//  ChatViewController.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/18.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var sticker: UIButton!
    @IBOutlet weak var send: UIButton!
    @IBOutlet weak var clear: UIButton!
    @IBOutlet weak var massage: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttomStackViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var stickerConstraint: NSLayoutConstraint!
    @IBOutlet weak var stickerCollectionView: UICollectionView!
    
    private let viewModel = ChatViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        scrollToBottom(row: IndexPath(row: (viewModel.history.count) - 1, section: 0), animated: false)
        notification()
    }
}

extension ChatViewController{
    
// MARK: - BindingViewModel
    
    private func bindViewModel() {
        viewModel.onOwnerUsersChanged = { [weak self] in
            let newIndex = IndexPath(row: (self?.viewModel.history.count ?? 0) - 1, section: 0)
            self?.tableView.insertRows(at: [newIndex], with: .right)
            self?.scrollToBottom(row: newIndex)
        }
        viewModel.onMassageChanged = { [weak self] in
            let newIndex = IndexPath(row: (self?.viewModel.history.count ?? 0) - 1, section: 0)
            self?.tableView.insertRows(at: [newIndex], with: .left)
            self?.scrollToBottom(row: newIndex)
        }
    }
    
// MARK: - UI
    
    private func setupUI() {
        setupButton()
        setupTableView()
        setupCollectionView()
        setupTextField()
    }
    
// MARK: - Button
    
    private func setupButton( ){
        sendButtonConfigura()
        stickerButtonConfigura()
        clearButtonConfigura()
    }
    
    private func sendButtonConfigura() {
        send.addTarget(self, action: #selector(sendButtonDidTap), for: .touchUpInside)
    }
    private func stickerButtonConfigura() {
        sticker.addTarget(self, action: #selector(stickerToggle), for: .touchUpInside)
    }
    
    private func clearButtonConfigura() {
        clear.addTarget(self, action: #selector(clearButtonDidTap), for: .touchUpInside)
    }

// MARK: - TableView
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "MassageSendTableViewCell",bundle: nil), forCellReuseIdentifier: "MassageSendTableViewCell")
        tableView.register(UINib(nibName: "ReplyMassageCell",bundle: nil), forCellReuseIdentifier: "ReplyMassageCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 160
        tableView.allowsSelection = false
    }
    
    private func scrollToBottom(row:IndexPath, animated: Bool = true) {
        DispatchQueue.main.async {
            if row.row > 0{
                self.tableView.scrollToRow(at: row, at: .top, animated: animated)
            }
        }
    }
    
// MARK: - TextField
    
    private func setupTextField() {
        massage.delegate = self
    }
    
// MARK: - CollectionView
    
    private func setupCollectionView() {
        let nib = UINib(nibName: "StickerCollectionViewCell", bundle: nil)
        stickerCollectionView.register(nib, forCellWithReuseIdentifier: "stickerCell")
        stickerCollectionView.delegate = self
        stickerCollectionView.dataSource = self
        stickerCollectionView.showsVerticalScrollIndicator = false
        stickerCollectionView.backgroundColor = .white
    }
    
    // MARK: - Notification
    
    private func notification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
// MARK: - Action
    @objc private func stickerToggle() {
        viewModel.isShowStickers.toggle() // false
        if viewModel.isShowStickers {
            stickerCollectionView.isHidden = false
        }
        self.stickerConstraint.constant = self.viewModel.isShowStickers ? 140 : 0
        
        UIView.animate(withDuration: 0.15, delay: .zero, options: .curveLinear) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.stickerCollectionView.isHidden = self.viewModel.isShowStickers ? false : true
        }
        UIView.animate(withDuration: 0.2) {
            if self.viewModel.history.count > 0 {
                self.tableView.scrollToRow(at: IndexPath(row: self.viewModel.history.count - 1 , section: 0), at: .top, animated: false)
            }
        }
    }
    
    @objc func stickerHide() {
        if viewModel.isShowStickers{
            print("TextFild isEditing")
            viewModel.isShowStickers = false
            self.stickerConstraint.constant = self.viewModel.isShowStickers ? 140 : 0
            
            UIView.animate(withDuration: 0.15, delay: .zero, options: .curveLinear) {
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.stickerCollectionView.isHidden = self.viewModel.isShowStickers ? false : true
            }
            UIView.animate(withDuration: 0.2) {
                if self.viewModel.history.count > 0 {
                    self.tableView.scrollToRow(at: IndexPath(row: self.viewModel.history.count - 1 , section: 0), at: .top, animated: false)
                }
            }
        }
    }
    
    @objc private func sendButtonDidTap() {
        guard let massageTextFieldText = massage.text, !massageTextFieldText.isEmpty else { return }
        // 送出訊息
        self.viewModel.sendMassage(massage: massageTextFieldText, sticker: nil)
        // 模擬回覆
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.viewModel.replyMassage()
        }
        massage.text = ""
    }
    
    @objc private func clearButtonDidTap() {
        viewModel.deleteHistory()
        tableView.reloadData()
        viewModel.threeFirendRandomTalk()
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardFrameEnd = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        let keyboardHeight = keyboardFrameEnd?.height ?? 0

        UIView.animate(withDuration: 0.2) {
            self.buttomStackViewConstraint?.constant = keyboardHeight - self.view.safeAreaInsets.bottom + 8
            self.view.layoutIfNeeded()
        }
        UIView.animate(withDuration: 0.2) {
            self.tableView.scrollToRow(at: IndexPath(row: self.viewModel.history.count - 1 , section: 0), at: .top, animated: false)
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        let lastIndex = IndexPath(row: viewModel.history.count - 1, section: 0)
        UIView.animate(withDuration: 0.5) {
            self.buttomStackViewConstraint?.constant = 0
            self.scrollToBottom(row: lastIndex)
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

//MARK: - UITextFieldDelegate

extension ChatViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, !text.isEmpty {
            viewModel.sendMassage(massage: text, sticker: nil)
        }
        textField.resignFirstResponder()
        return true
    }
}


// MARK: - UITableViewDelegate

extension ChatViewController: UITableViewDelegate { }

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let massage = viewModel.getHistory(at: indexPath.row)
        
        
        if massage.user.name == "Me" {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MassageSendTableViewCell", for: indexPath) as? MassageSendTableViewCell {
                cell.configure(time: massage.time.dateFormatter(),
                               isUseSticker: massage.isUseSticker,
                               massage: massage.massage ?? "",
                               sticker: massage.sticker ?? "")
                cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
                return cell
            }
            return cell
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ReplyMassageCell", for: indexPath) as? ReplyMassageCell {
                cell.configure(user: massage.user.name,
                               userImage: massage.user.image,
                               time: massage.time.dateFormatter(),
                               isUseSticker: massage.isUseSticker,
                               massage: massage.massage ?? "",
                               sticker: massage.sticker ?? "")
                cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
                return cell
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let massage = viewModel.getHistory(at: indexPath.row)
        return massage.isUseSticker ? 140 : 120
    }
}

// MARK: - UICollectionViewDelegate

extension ChatViewController: UICollectionViewDelegateFlowLayout { }

extension ChatViewController: UICollectionViewDelegate { }

extension ChatViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.stickerList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stickerCell", for: indexPath) as! StickerCollectionViewCell
        cell.configure(sticker: viewModel.stickerList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: stickerCollectionView.frame.width / 4, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     // 送出訊息
        self.viewModel.sendMassage(massage: nil, sticker: viewModel.stickerList[indexPath.row])
     // 模擬回覆
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        self.viewModel.replyMassage()
        }
    }
}

