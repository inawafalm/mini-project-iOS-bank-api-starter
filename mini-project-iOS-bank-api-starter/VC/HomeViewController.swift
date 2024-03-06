//
//  ViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Nawaf Almutairi on 05/03/2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    let signINButton =  UIButton(type: .system)
     let signUPButton =  UIButton(type: .system)
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Account"
        
        setUpUI()
        subView()
        autoLayout()
        setupNavigationBar()
        
        signUPButton.addTarget(self, action: #selector(ButtonToSignUP), for: .touchUpInside)
        signINButton.addTarget(self, action: #selector(ButtonToSignIN), for: .touchUpInside)
    }
    
    
    
    func subView(){
        view.backgroundColor = .white
        view.addSubview(signINButton)
        view.addSubview(signUPButton)

    }
    
    func setUpUI(){
        signINButton.setTitle("Sign in", for: .normal)
        signUPButton.setTitle("Sign up", for: .normal)

    }
    
    func autoLayout(){
        signINButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        signUPButton.snp.makeConstraints { make in
            make.top.equalTo(signINButton.snp.top).offset(100)
            make.centerX.equalToSuperview()
            
        }
    }
    
    func setupNavigationBar(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    @objc func ButtonToSignUP(){
        let signupVC = SignUpViewController()
        self.navigationController?.pushViewController(signupVC, animated: true)
    }
    @objc func ButtonToSignIN(){
        let signinVC = SignInViewController()
        self.navigationController?.pushViewController(signinVC, animated: true)
    }
    


}

