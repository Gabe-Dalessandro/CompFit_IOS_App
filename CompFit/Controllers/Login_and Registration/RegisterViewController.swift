//
//  RegisterViewController.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 2/5/21.
//

import UIKit


class RegisterViewController: UIViewController {
    
    var emailView = RegistrationEmailView()
    var passwordView = RegistrationPasswordView()
    var phoneNumberView = RegistrationPhoneNumberView()
    var registerButton = RegisterButton()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        emailView.setEmailView(superview: view)
        emailView.emailTextField.delegate = self
        
        passwordView.setPasswordView(superview: view, emailView: emailView)
        passwordView.passwordTextField.delegate = self
        
        phoneNumberView.setPhoneNumberView(superview: view, passwordView: passwordView)
        phoneNumberView.phoneNumberTextField.delegate = self
        
        registerButton.setRegisterButton(superview: view)
        registerButton.addTarget(self, action: #selector(registerPressed), for: .touchUpInside)
    }
    
    
    @objc
    func registerPressed(recognizer: UITapGestureRecognizer) {
        
        if (emailView.emailTextField.text != "") && (passwordView.passwordTextField.text != "") && (phoneNumberView.phoneNumberTextField.text != "") {
            transitionToOnboarding()
        } else {
            print("one of the fields were left blank")
        }
    }


    
    func transitionToOnboarding() {
//        let email = "jsnow@gmail.com"
//        let password = "fitness123"
//        let phoneNumber = "5703325722"

        let onboardingViewController = OnboardingViewController()
        onboardingViewController.modalPresentationStyle = .fullScreen
        onboardingViewController.emailStr = emailView.emailTextField.text!
        onboardingViewController.passwordStr = passwordView.passwordTextField.text!
        onboardingViewController.phoneNumberStr = phoneNumberView.phoneNumberTextField.text!

        self.navigationController?.pushViewController(onboardingViewController, animated: true)
    }
}
 
    
   

extension RegisterViewController: UITextFieldDelegate {

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
            } else if (phoneNumberView.phoneNumberTextField.isEditing) {
                textField.placeholder = "Enter phone number!"
            }

            return false;
        }
    }



    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(emailView.emailTextField.isEditing) {
            emailView.emailTextField.endEditing(true)
            return true
        } else if (passwordView.passwordTextField.isEditing) {
            passwordView.passwordTextField.endEditing(true)
            return true
        } else if (phoneNumberView.phoneNumberTextField.isEditing) {
            phoneNumberView.phoneNumberTextField.endEditing(true)
            return true
        }

        return true;
    }
}
