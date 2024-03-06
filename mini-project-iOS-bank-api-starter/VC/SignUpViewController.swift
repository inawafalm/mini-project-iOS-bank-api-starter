//
//  SignUpViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by fatma adnan on 06/03/2024.
//

import UIKit
import Eureka
import SnapKit
import Kingfisher
import Alamofire

class SignUpViewController: FormViewController{
    
    var token: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUp()
    }
    
    
    func setUp(){
        form +++ Section("Sign Up")
        <<< TextRow{ row in
            row.title = "Username"
            row.placeholder = "Enter your username here"
            row.tag = "Username"
            //red color and error
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid{
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        <<< TextRow{ row in
            row.title = "Password"
            row.placeholder = "Enter your password here"
            row.tag = "Password"
            
            //red color and error
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid{
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        <<< EmailRow{ row in
            row.title = "Email"
            row.placeholder = "Enter your email"
            row.tag = "Email"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid{
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        +++ Section()
        <<< ButtonRow{ row in
            row.title = "Sign Up"
            row.onCellSelection { cell, row in
                self.signUp()
            }
        }
    }
    
    @objc func signUp(){
        let errors = form.validate()
        guard errors.isEmpty else{
            presentAlertWithTitle(title: "🚨", message: "\(errors.count) fields are missing")
            return
        }
        //getting data from the row
        let usernameRow: TextRow? = form.rowBy(tag: "username")
        let passwordRow: TextRow? = form.rowBy(tag: "password")
        let emailRow: EmailRow? = form.rowBy(tag: "email")
        
        
        //convert data to string ,INT ,etc
        let username = usernameRow?.value ?? ""
        let password = passwordRow?.value ?? ""
        let email = emailRow?.value ?? ""
        
        
        print(username)
        let user = User(username: username, email: email, password: password)
        
        
        
        NetworkManager.shared.signup(user: user) { result in
            switch result {
            case.success(let tokenResponse):
                print("Successful Token\(tokenResponse.token)")
                
                
                
            case.failure(let afError):
                print(afError)
            }
        }
        
    }
    
    func presentAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
    
}



 



//        let usernameTextField: UITextField = {
//            let textField = UITextField()
//            textField.placeholder = "Username"
//            textField.borderStyle = .roundedRect
//            return textField
//        }()
//    let emailTextFeild: UITableFeild ={
//        
//    }
//
////    let EmailTextFeild:{ row in
////                row.title = "Email"
////                row.placeholder = "Enter your email"
////                row.tag = "Email"
////                row.add(rule: RuleRequired())
////                row.validationOptions = .validatesOnChange
////                row.cellUpdate { cell, row in
////                    if !row.isValid{
////                        cell.titleLabel?.textColor = .red
////                    }
//        let passwordTextField: UITextField = {
//            let textField = UITextField()
//            textField.placeholder = "Password"
//            textField.isSecureTextEntry = true
//            textField.borderStyle = .roundedRect
//            return textField
//        }()
//
//        let signUpButton: UIButton = {
//            let button = UIButton(type: .system)
//            button.setTitle("Sign Up", for: .normal)
//            button.addTarget(SignUpViewController.self, action: #selector(signUpTapped), for: .touchUpInside)
//            return button
//        }()
//
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            view.backgroundColor = .white
//
//            setupUI()
//            setConstraints()
//        }
//
//        func setupUI() {
//            view.addSubview(usernameTextField)
//            view.addSubview(passwordTextField)
//            view.addSubview(signUpButton)
//        }
//
//        func setConstraints() {
//            usernameTextField.snp.makeConstraints { make in
//                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
//                make.leading.trailing.equalToSuperview().inset(16)
//                make.height.equalTo(40)
//            }
//
//            passwordTextField.snp.makeConstraints { make in
//                make.top.equalTo(usernameTextField.snp.bottom).offset(20)
//                make.leading.trailing.equalToSuperview().inset(16)
//                make.height.equalTo(40)
//            }
//
//            signUpButton.snp.makeConstraints { make in
//                make.top.equalTo(passwordTextField.snp.bottom).offset(30)
//                make.leading.trailing.equalToSuperview().inset(16)
//                make.height.equalTo(40)
//            }
//        }
//
//        @objc func signUpTapped() {
//            // Implement sign-up logic here
//            print("Sign Up tapped!")
//        }
//    }
