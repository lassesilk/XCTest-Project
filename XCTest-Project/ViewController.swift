//
//  ViewController.swift
//  XCTest-Project
//
//  Created by Lasse Silkoset on 24/05/2020.
//  Copyright © 2020 Lasse Silkoset. All rights reserved.
//

struct User {
    let username: String
    let password: String
}

import UIKit

class ViewController: UIViewController {
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "  username"
        tf.backgroundColor = .white
        tf.constrainHeight(constant: 50)
        tf.autocapitalizationType = .none
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "  password"
        tf.backgroundColor = .white
        tf.constrainHeight(constant: 50)
        tf.autocapitalizationType = .none
        return tf
    }()
    
    lazy var loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Login", for: .normal)
        btn.backgroundColor = .white
        btn.titleLabel?.textColor = .black
        btn.constrainWidth(constant: 250)
        btn.constrainHeight(constant: 50)
        btn.layer.cornerRadius = 25
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(didTapLoginButton(_:)), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        validation = ValidationService()
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        let stack = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField, loginButton])
        stack.axis = .vertical
        stack.spacing = 48
        
        view.addSubview(stack)
        stack.centerInSuperview()
    }
    
    private let dummyDatabase = [User(username: "lassesilk", password: "password1")]
    
    private var validation: ValidationService!
    
  
    
    @objc fileprivate func didTapLoginButton(_ sender: Any) {
        do {
            let username = try validation.validateUsername(usernameTextField.text)
            let password = try validation.validatePassword(passwordTextField.text)
            
            // Login to database...
            if let user = dummyDatabase.first(where: { user in
                user.username == username && user.password == password
            }) {
                presentAlert(with: "You successfully logged in as \(user.username)")
                
            } else {
                throw LoginError.invalidCredentials
            }
            
        } catch {
            present(error)
        }
    }
}

extension ViewController {
    
    enum LoginError: LocalizedError {
        case invalidCredentials
        
        var errorDescription: String? {
            switch self {
            case .invalidCredentials:
                return "Incorrect username or password. Please try again."
            }
        }
    }
}


