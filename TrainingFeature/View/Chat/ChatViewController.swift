//
//  ChatViewController.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/18.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var image: UIButton!
    @IBOutlet weak var send: UIButton!
    @IBOutlet weak var massage: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottonStack: UIStackView!
    
    let viewModel = ChatViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
}

extension ChatViewController{
    
// MARK: - BindingViewModel
    
    private func bindViewModel() {
        viewModel.onOwnerUsersChanged = { [weak self] in
                let newIndex = IndexPath(row: (self?.viewModel.history.count ?? 0) - 1, section: 0)
                self?.tableView.insertRows(at: [newIndex], with: .top)
                self?.scrollToBottom(row: newIndex)
            
        }
        viewModel.onMassageChanged = { [weak self] in
                let newIndex = IndexPath(row: (self?.viewModel.history.count ?? 0) - 1, section: 0)
                self?.tableView.insertRows(at: [newIndex], with: .top)
                self?.scrollToBottom(row: newIndex)
        }
    }
    
// MARK: - UI
    
    private func setupUI() {
        setupButton()
        setupScrollView()
        setupTableView()
    }

// MARK: - Button
    
    private func setupButton( ){
        sendButtonConfigura()
        imageButtonConfigura()
    }
    
    private func sendButtonConfigura() {
        send.addTarget(self, action: #selector(sendButtonDidTap), for: .touchUpInside)
    }
    private func imageButtonConfigura() {
        image.addTarget(self, action: #selector(imageButtonDidTap), for: .touchUpInside)
    }
    
// MARK: - ScrollView
    
    private func setupScrollView() {
    
    }
    
// MARK: - TableView
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "MassageSendTableViewCell",bundle: nil), forCellReuseIdentifier: "MassageSendTableViewCell")
        tableView.register(UINib(nibName: "ReplyMassageCell",bundle: nil), forCellReuseIdentifier: "ReplyMassageCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 160
    }
    
    private func scrollToBottom(row:IndexPath) {
        DispatchQueue.main.async {
            if row.row > 0{
                self.tableView.scrollToRow(at: row, at: .top, animated: true)
            }
        }
    }

    @objc private func sendButtonDidTap() {
        guard let massageTextFieldText = massage.text, !massageTextFieldText.isEmpty else { return }
        // 送出訊息
            self.viewModel.sendMassage(massage: massageTextFieldText, image: nil)
        // 模擬回覆
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.viewModel.replyMassage()
        }
        massage.text = ""
    }
    
    @objc private func imageButtonDidTap() {
        // 跳出 image 畫面
    }
}


// MARK: - UITableViewDelegate

extension ChatViewController: UITableViewDelegate { }

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tableviewCellrow \(viewModel.history.count)")
        return viewModel.history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let massage = viewModel.getHistory(at: indexPath.row)
        
        if indexPath.row % 2 == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MassageSendTableViewCell", for: indexPath) as? MassageSendTableViewCell {
                cell.configure(time: massage.time,
                               isUseImage: massage.isUseImage,
                               massage: massage.massage ?? "",
                               image: massage.image ?? "")
                return cell
            }
            return cell
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ReplyMassageCell", for: indexPath) as? ReplyMassageCell {
                cell.configure(user: massage.user.name,
                               userImage: massage.user.image,
                               time: massage.time,
                               isUseImage: massage.isUseImage,
                               massage: massage.massage ?? "",
                               image: massage.image ?? "")
                return cell
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let massage = viewModel.getHistory(at: indexPath.row)
        return massage.isUseImage ? 160 : 60
    }
    
}
