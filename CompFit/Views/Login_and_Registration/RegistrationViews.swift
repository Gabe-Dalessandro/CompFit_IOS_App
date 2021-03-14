//
//  RegistrationViews.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/4/21.
//

import UIKit

//var textFieldImageView = UIImageView(image: UIImage(named: "textfield"))

class RegistrationEmailView: UIView {
    
    var emailTextField = UITextField()
    var emailImageView = UIImageView(image: UIImage(named: "textfield"))
    
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setEmailView(superview: UIView){
        //set the entire view area
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: 150).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        self.heightAnchor.constraint(equalToConstant: 140).isActive = true
    
    
        //set the image view for the text box
        self.addSubview(emailImageView)
        emailImageView.translatesAutoresizingMaskIntoConstraints = false
        emailImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        emailImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        emailImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        emailImageView.heightAnchor.constraint(equalToConstant: 110).isActive = true

        
        //set the email text field
        self.addSubview(emailTextField)
        emailTextField.textAlignment = .center
        emailTextField.textColor = .systemTeal
        emailTextField.font = .systemFont(ofSize: 25)
        emailTextField.placeholder = "Email"
        emailTextField.autocapitalizationType = .none

        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
}







class RegistrationPasswordView: UIView {
        
    var passwordTextField = UITextField()
    var passwordImageView = UIImageView(image: UIImage(named: "textfield"))
    
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setPasswordView(superview: UIView, emailView: UIView){
        //set the view to the superview
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: emailView.bottomAnchor, constant: 10).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        self.heightAnchor.constraint(equalToConstant: 140).isActive = true


        //set the text box image
        self.addSubview(passwordImageView)
        passwordImageView.translatesAutoresizingMaskIntoConstraints = false
        passwordImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        passwordImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        passwordImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        passwordImageView.heightAnchor.constraint(equalToConstant: 110).isActive = true


        //set the password text field
        self.addSubview(passwordTextField)
        passwordTextField.textAlignment = .center
        passwordTextField.textColor = .systemTeal
        passwordTextField.font = .systemFont(ofSize: 25)
        passwordTextField.placeholder = "Password"
        passwordTextField.autocapitalizationType = .none

        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
}





class RegistrationPhoneNumberView: UIView {
        
    var phoneNumberTextField = UITextField()
    var phoneNumberImageView = UIImageView(image: UIImage(named: "textfield"))
    
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setPhoneNumberView(superview: UIView, passwordView: UIView){
        //set the view to the superview
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: 10).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        self.heightAnchor.constraint(equalToConstant: 140).isActive = true


        //set the text box image
        self.addSubview(phoneNumberImageView)
        phoneNumberImageView.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        phoneNumberImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        phoneNumberImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        phoneNumberImageView.heightAnchor.constraint(equalToConstant: 110).isActive = true


        //set the phoneNumber text field
        self.addSubview(phoneNumberTextField)
        phoneNumberTextField.textAlignment = .center
        phoneNumberTextField.textColor = .systemTeal
        phoneNumberTextField.font = .systemFont(ofSize: 25)
        phoneNumberTextField.placeholder = "Phone Number"
        phoneNumberTextField.autocapitalizationType = .none

        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        phoneNumberTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60).isActive = true
        phoneNumberTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60).isActive = true
        phoneNumberTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
    
    
    
        //Create a "done" button for the keyboard
        let doneToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: superview.safeAreaLayoutGuide.layoutFrame.width, height: 50))
        doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barBtnDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneButtonAction))
        doneToolbar.items = [flexSpace, barBtnDone]
        phoneNumberTextField.inputAccessoryView = doneToolbar
    
    }
    
    @objc func doneButtonAction(){
            phoneNumberTextField.resignFirstResponder()
    }
    
}





class RegisterButton: UIButton {
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setRegisterButton(superview: UIView) {
        superview.addSubview(self)
        self.backgroundColor = Constants.deepOrange
        self.setTitleColor(.systemTeal, for: .normal)
        self.setTitle("Register", for: .normal)
        self.titleLabel?.font = .boldSystemFont(ofSize: 30)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 65).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 100).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -100).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -175).isActive = true
        self.layer.cornerRadius = 15
    }
}
