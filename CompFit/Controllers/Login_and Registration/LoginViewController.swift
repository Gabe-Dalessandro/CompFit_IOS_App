//
//  LoginViewController.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 2/5/21.
//

import UIKit



class LoginViewController: UIViewController {
    
    var emailView = LoginEmailView()
    var passwordView = LoginPasswordView()
    var loginButton = LoginButton()
    
    //api route to login a user
//    let loginUrlStr = Endpoint.login


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        emailView.setEmailView(superview: view)
        emailView.emailTextField.delegate = self
        
        passwordView.setPasswordView(superview: view, emailView: emailView)
        passwordView.passwordTextField.delegate = self

        loginButton.setLoginButton(superview: view)
        loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
    }
    
    

    @objc func loginPressed(recognizer: UITapGestureRecognizer) {

        emailView.emailTextField.text = "jsnow@gmail.com"
        passwordView.passwordTextField.text = "fitness123"

        let email = emailView.emailTextField.text
        let password = passwordView.passwordTextField.text

        if (email != "" && password != "") {
            let success = LoginNetworking.loginUser(email!, password!)
            if success {
                transitionToMainApp()
            } else {
                print(success)
                print("Error logging in")
            }
        } else {
            print("no email entered or password entered")
        }
    }

    
    func transitionToMainApp() {
        let mainTabBarController = MainTabBarController()
        mainTabBarController.viewControllers = []
        mainTabBarController.modalPresentationStyle = .fullScreen
        mainTabBarController.isModalInPresentation = false

        present(mainTabBarController, animated: true, completion: nil)
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
        if(emailView.emailTextField.isEditing) {
            emailView.emailTextField.endEditing(true);
            return false;
        } else if (passwordView.passwordTextField.isEditing) {
            passwordView.passwordTextField.endEditing(true);
            return false;
        }

        return true;
    }
}
