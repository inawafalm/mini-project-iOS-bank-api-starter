//
//  SignInViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by fatma adnan on 06/03/2024.
//

import UIKit
import Alamofire
import Kingfisher
import SnapKit
import Eureka
//
//class SignInViewController: UIViewController {
//    
//    let usernameTextField: UITextField! = nil 
//    let passwordTextField: UITextField!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        signInButtonTapped(UIButton)
//        
//        view.addSubview(usernameTextField)
//        view.addSubview(passwordTextField)
//    }
//    
//        //sign-in button
//        func signInButtonTapped(_ sender: UIButton) {
//            guard let username = usernameTextField.text, !username.isEmpty,
//                let password = passwordTextField.text, !password.isEmpty else {
//                showAlert(message: "Username & password")
//                return
//            }
//            
//            let jsonData: [String: Any] = ["username": username, "password": password]
//            
//            guard let requestData = try? JSONSerialization.data(withJSONObject: jsonData) else {
//                showAlert(message: "Error")
//                return
//            }
//            
//            guard let url = URL(string: "https://coded-bank-api.eapi.joincoded.com/signin") else {
//                showAlert(message: "Invalid URL.")
//                return
//            }
//            
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.httpBody = requestData
//            
//            URLSession.shared.dataTask(with: request) { data, response, error in
//                
//                if let error = error {
//                    self.showAlert(message: "Error: \(error.localizedDescription)")
//                    return
//                }
//                
//                if data != nil {
//                    
//                }
//            }.resume()
//        }
//
//  
//        func showAlert(message: String) {
//            DispatchQueue.main.async {
//                let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
//                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                self.present(alertController, animated: true, completion: nil)
//            }
//        }
//    }
//        
//    
//
//
//
//
//    
//    
class SignInViewController: FormViewController {
    
    var token: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpForm()
    }
    
    func setUpForm(){
        form +++ Section("Sign In ")
        <<< TextRow(){row in
            row.title = "Username"
            row.placeholder = "Enter Username"
            row.tag = "UserName"
            
            //red color and error
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid{
                    cell.titleLabel?.textColor = .red
                }
            }}
            
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
            
            form +++ Section("")
            
            <<< ButtonRow(){ row in
                row.title = "Sign In"
                row.onCellSelection { cell, row in
                    self.signIn()
                }
            }
        }
        
    
    
    @objc func signIn(){
        let errors = form.validate()
        guard errors.isEmpty else{
            presentAlertWithTitle(title: "🚨", message: "\(errors.count) fields are missing")
            return
        }
        //getting data from the row
        let usernameRow: TextRow? = form.rowBy(tag: "UserName")
        let passwordRow: TextRow? = form.rowBy(tag: "Password")
        
        
        //convert data to string ,INT ,etc
        let username = usernameRow?.value ?? ""
        let password = passwordRow?.value ?? ""
        
        
        print(username)
        let user = User(username: username,email: "", password: password)
        
        
        
        NetworkManager.shared.signin(user: user) { result in
            switch result {
            case .success(let tokenResponse):
                
                print("Sign in successful. Token: \(tokenResponse.token)")
                DispatchQueue.main.async {
                   
                                    
                    let signVC = AccountViewController()
                    signVC.token = tokenResponse.token
                    self.navigationController?.pushViewController(signVC, animated: true)

                }
            case .failure(let error):
                
                print("Sign in failed with error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                }
            }
        }
    }

    private func presentAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
}


