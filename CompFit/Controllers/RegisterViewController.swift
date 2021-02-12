//
//  RegisterViewController.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 2/5/21.
//

import UIKit

class RegisterViewController: UIViewController {
    
    var emailView = UIView()
    var passwordView = UIView()
    var phoneNumberView = UIView()
    
    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    var phoneNumberTextField = UITextField()
    
    var registerButton = UIButton()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        phoneNumberTextField.delegate = self
        
        setEmailView()
        setPasswordView()
        setPhoneNumberView()
        setRegisterButton()
    }
    
    
    

    
    
    func setEmailView() {
        //set teh view in within the VC
        self.view.addSubview(emailView)
        emailView.translatesAutoresizingMaskIntoConstraints = false
        emailView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150).isActive = true
        emailView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        emailView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        emailView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        //create the email text box image
        let emailImageView = UIImageView(image: UIImage(named: "textfield"))

        emailView.addSubview(emailImageView)
        emailImageView.translatesAutoresizingMaskIntoConstraints = false
        emailImageView.topAnchor.constraint(equalTo: emailView.topAnchor, constant: 30).isActive = true
        emailImageView.leadingAnchor.constraint(equalTo: emailView.leadingAnchor, constant: 20).isActive = true
        emailImageView.trailingAnchor.constraint(equalTo: emailView.trailingAnchor, constant: -20).isActive = true
        emailImageView.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
        
        //set the email text field
        emailView.addSubview(emailTextField)
        emailTextField.textAlignment = .center
        emailTextField.textColor = .systemTeal
        emailTextField.font = .systemFont(ofSize: 25)
        emailTextField.placeholder = "Email"
        emailTextField.autocapitalizationType = .none
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.topAnchor.constraint(equalTo: emailView.topAnchor, constant: 40).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: emailView.leadingAnchor, constant: 60).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: emailView.trailingAnchor, constant: -60).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    

    func setPasswordView() {
        //set teh view in within the VC
        self.view.addSubview(passwordView)
        passwordView.translatesAutoresizingMaskIntoConstraints = false
        passwordView.topAnchor.constraint(equalTo: emailView.bottomAnchor, constant: 10).isActive = true
        passwordView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        passwordView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        passwordView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        
        //create the password text box image
        let passwordImageView = UIImageView(image: UIImage(named: "textfield"))

        passwordView.addSubview(passwordImageView)
        passwordImageView.translatesAutoresizingMaskIntoConstraints = false
        passwordImageView.topAnchor.constraint(equalTo: passwordView.topAnchor).isActive = true
        passwordImageView.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor, constant: 20).isActive = true
        passwordImageView.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor, constant: -20).isActive = true
        passwordImageView.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
        
        //set the password text field
        passwordView.addSubview(passwordTextField)
        passwordTextField.textAlignment = .center
        passwordTextField.textColor = .systemTeal
        passwordTextField.font = .systemFont(ofSize: 25)
        passwordTextField.placeholder = "Password"
        passwordTextField.autocapitalizationType = .none
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: 10).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor, constant: 60).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor, constant: -60).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    
    func setPhoneNumberView() {
        //set teh view in within the VC
        self.view.addSubview(phoneNumberView)
        phoneNumberView.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberView.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: 10).isActive = true
        phoneNumberView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        phoneNumberView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        phoneNumberView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
    
        //create the password text box image
        let phoneNumberImageView = UIImageView(image: UIImage(named: "textfield"))

        phoneNumberView.addSubview(phoneNumberImageView)
        phoneNumberImageView.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberImageView.topAnchor.constraint(equalTo: phoneNumberView.topAnchor).isActive = true
        phoneNumberImageView.leadingAnchor.constraint(equalTo: phoneNumberView.leadingAnchor, constant: 20).isActive = true
        phoneNumberImageView.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor, constant: -20).isActive = true
        phoneNumberImageView.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
        
        //set the password text field
        phoneNumberView.addSubview(phoneNumberTextField)
        phoneNumberTextField.textAlignment = .center
        phoneNumberTextField.textColor = .systemTeal
        phoneNumberTextField.font = .systemFont(ofSize: 25)
        phoneNumberTextField.placeholder = "Phone Number"
        phoneNumberTextField.autocapitalizationType = .none
        phoneNumberTextField.keyboardType = .numberPad
        
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberTextField.topAnchor.constraint(equalTo: phoneNumberView.topAnchor, constant: 10).isActive = true
        phoneNumberTextField.leadingAnchor.constraint(equalTo: phoneNumberView.leadingAnchor, constant: 60).isActive = true
        phoneNumberTextField.trailingAnchor.constraint(equalTo: phoneNumberView.trailingAnchor, constant: -60).isActive = true
        phoneNumberTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
    
        //Create a "done" button for the keyboard
        let doneToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.safeAreaLayoutGuide.layoutFrame.width, height: 50))
        doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barBtnDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneButtonAction))
        doneToolbar.items = [flexSpace, barBtnDone]
        phoneNumberTextField.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
        {
            phoneNumberTextField.resignFirstResponder()
        }
    
    
    
    
    private func setRegisterButton() {
        registerButton.backgroundColor = .systemOrange
        registerButton.setTitleColor(.systemTeal, for: .normal)
        registerButton.setTitle("Register", for: .normal)
        registerButton.titleLabel?.font = .boldSystemFont(ofSize: 30)
        
        self.view.addSubview(registerButton)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.heightAnchor.constraint(equalToConstant: 65).isActive = true
        registerButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 100).isActive = true
        registerButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -100).isActive = true
        registerButton.topAnchor.constraint(equalTo: phoneNumberView.bottomAnchor, constant: 10).isActive = true
        registerButton.layer.cornerRadius = 15
        
        registerButton.addTarget(self, action: #selector(registerPressed), for: .touchUpInside)
    }
    
    
    @objc
    func registerPressed(recognizer: UITapGestureRecognizer) {
        if (emailTextField.text != "") && (passwordTextField.text != "") && (phoneNumberTextField.text != "") {
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
        onboardingViewController.emailStr = emailTextField.text!
        onboardingViewController.passwordStr = passwordTextField.text!
        onboardingViewController.phoneNumberStr = phoneNumberTextField.text!
        
//        present(onboardingViewController, animated: true, completion: nil)
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
            if(emailTextField.isEditing) {
                textField.placeholder = "Enter email!"
            } else if (passwordTextField.isEditing) {
                textField.placeholder = "Enter password!"
            } else if (phoneNumberTextField.isEditing) {
                textField.placeholder = "Enter phone number!"
            }

            return false;
        }
    }
    
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(emailTextField.isEditing) {
            emailTextField.endEditing(true)
            return true
        } else if (passwordTextField.isEditing) {
            passwordTextField.endEditing(true)
            return true
        } else if (phoneNumberTextField.isEditing) {
            phoneNumberTextField.endEditing(true)
            return true
        }

        return true;
    }
}
