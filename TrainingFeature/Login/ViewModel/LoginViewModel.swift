//
//  LoginViewModel.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/17.
//

import Foundation
import UIKit

class LoginViewModel {
    
    static let shared: LoginViewModel = LoginViewModel()
    
    var users: [User] = [User(account: "admin", password: "password", gender: "Male", education: "high school")]
    var account: String = ""
    var password: String = ""
    var loginStatus: ((Bool) -> Void)?
}

// MARK: - Sub

extension LoginViewModel{
    
    func login(){
        let success = users.contains(where: { $0.account == account && $0.password == password })
        loginStatus?(success)
    }
    
    func register(account: String, password: String, gender: String, education: String) {
        users.append(User(account: account, password: password, gender: gender, education: education))
        print("register success")
    }
}

