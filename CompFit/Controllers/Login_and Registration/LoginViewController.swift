//
//  LoginViewController.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 2/5/21.
//

import UIKit
import SafariServices



class LoginViewController: UIViewController {
    
    private var emailView = LoginEmailView()
    private var passwordView = LoginPasswordView()
//    private var loginButton = LoginButton()

    private let headerView = LoginHeaderView()

    private let emailField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = "Email Address"
        field.keyboardType = .emailAddress
        field.returnKeyType = .next
        field.autocorrectionType = .no
        return field
    }()
    
    private let passwordField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = "Password"
        field.isSecureTextEntry = true
        field.keyboardType = .default
        field.returnKeyType = .continue
        field.autocorrectionType = .no
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = Constants.Colors.brandDarkGrey
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.poppinsRegular(size: 20)
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(Constants.Colors.brandBlue, for: .normal)
        button.setTitle("Terms of Service", for: .normal)
        return button
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        addSubviews()
        
        emailField.delegate = self
        passwordField.delegate = self
        
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTerms), for: .touchUpInside)

        
//        emailView.setEmailView(superview: view)
//        emailView.emailTextField.delegate = self
//
//        passwordView.setPasswordView(superview: view, emailView: emailView)
//        passwordView.passwordTextField.delegate = self
//
//        loginButton.setLoginButton(superview: view)
//        loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: (view.height - view.safeAreaInsets.top)/3.0)
        
        emailField.frame = CGRect(x: 25, y: headerView.bottom + 20, width: view.width - 50, height: 50)
        
        passwordField.frame = CGRect(x: 25, y: emailField.bottom + 10, width: view.width - 50, height: 50)
        
        loginButton.frame = CGRect(x: 25, y: passwordField.bottom + 20, width: view.width - 50, height: 50)
        
        termsButton.frame = CGRect(x: 25, y: loginButton.bottom + 50, width: view.width - 50, height: 50)
    }
    
    

    private func addSubviews() {
        view.addSubview(headerView)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
    }
    
    
    @objc private func didTapLogin() {
        // Dismiss the keyboard
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        // Testing
//        emailField.text = "jsnow@gmail.com"
//        passwordField.text = "fitness123"
        
        // Check if: fields aren't empty,they aren't just filled with whitespaces,
            // and check proper password strength
        guard let email = emailField.text, let password = passwordField.text,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 8 else {
            
            return
        }
        
        // Login
        let errorMessage = LoginNetworking.loginUser(email, password)
        if (errorMessage == "") {
            transitionToMainApp()
        } else {
            let alert = UIAlertController(title: "Unsuccessful Login", message: errorMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc private func didTapTerms() {
        guard let url = URL(string: "https://www.instagram.com") else {
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }

    
    private func transitionToMainApp() {
        let mainTabBarController = MainTabBarController()
        mainTabBarController.viewControllers = []
        mainTabBarController.modalPresentationStyle = .fullScreen
        mainTabBarController.isModalInPresentation = false

        present(mainTabBarController, animated: true, completion: nil)
    }
    
    
    private func login() {
        
    }
    
}




extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        //dismissed if something was typed
        if (textField.text != "") {
            return true
        }
        //will stay if user didn't type anything yet
        else {
            if(emailView.emailTextField.isEditing) {
                textField.placeholder = "Enter email!"
            } else if (passwordView.passwordTextField.isEditing) {
                textField.placeholder = "Enter password!"
            }

            return false;
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == emailField) {
            passwordField.becomeFirstResponder()
        }
        else if (textField == passwordField){
            textField.resignFirstResponder()
            didTapLogin()
        }
        
        return true
    }
    

//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if(emailView.emailTextField.isEditing) {
//            emailView.emailTextField.endEditing(true);
//            return false;
//        } else if (passwordView.passwordTextField.isEditing) {
//            passwordView.passwordTextField.endEditing(true);
//            return false;
//        }
//
//        return true;
//    }
}
