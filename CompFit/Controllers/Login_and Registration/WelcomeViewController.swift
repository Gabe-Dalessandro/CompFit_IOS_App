//
//  WelcomeViewController.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 2/5/21.
//

import UIKit

class WelcomeViewController: UIViewController {

    private func addLogo() {
        let logo = UIImage(named: "logo")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        self.view.addSubview(imageView)
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 75).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -75).isActive = true
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 250).isActive = true
    }
    
    
    private func addRegisterButton() {
        let registerButton = UIButton()
        registerButton.backgroundColor = .systemGray
        registerButton.setTitleColor(Constants.deepOrange, for: .normal)
        registerButton.setTitle("Register", for: .normal)
        registerButton.titleLabel?.font = .boldSystemFont(ofSize: 30)
        
        self.view.addSubview(registerButton)
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.heightAnchor.constraint(equalToConstant: 65).isActive = true
        registerButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        registerButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 640).isActive = true
        
        registerButton.addTarget(self, action: #selector(registerPressed), for: .touchUpInside)
    }
    
    @objc
    func registerPressed(recognizer: UITapGestureRecognizer) {
        let registerViewController = RegisterViewController()
        self.navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    
    private func addLoginButton() {
        let loginButton = UIButton()
        loginButton.backgroundColor = Constants.deepOrange
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = .boldSystemFont(ofSize: 30)
        
        self.view.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.heightAnchor.constraint(equalToConstant: 65).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 720).isActive = true
        
        loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
    }
    
    @objc
    func loginPressed(recognizer: UITapGestureRecognizer) {
        let loginViewController = LoginViewController()
        self.navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addLogo()
        addRegisterButton()
        addLoginButton()
        // Do any additional setup after loading the view.
    }


}
