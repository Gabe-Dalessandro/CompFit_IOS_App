//
//  LoginViews.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/1/21.
//

import UIKit

class LoginHeaderView: UIView {
    
    private var gradientLayer: CAGradientLayer?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo-horizontal")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        createGradient()
        
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createGradient(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [Constants.Colors.brandBlue.cgColor, Constants.Colors.brandPink.cgColor]
        layer.addSublayer(gradientLayer)
        self.gradientLayer = gradientLayer
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = layer.bounds
        
        imageView.frame = CGRect(x: width/4, y: 20, width: width/2, height: height - 40)
    }
    
    
}


class LoginEmailView: UIView {
    
    var emailTextField = UITextField()
    var emailImageView = UIImageView(image: UIImage(named: "textfield"))
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
//    init() {
//        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
//    }

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




class LoginPasswordView: UIView {
        
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


        //set the text box
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




class LoginButton: UIButton {
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLoginButton(superview: UIView) {
        superview.addSubview(self)
        self.backgroundColor = Constants.Colors.brandPink
        self.setTitleColor(.systemTeal, for: .normal)
        self.setTitle("Login", for: .normal)
        self.titleLabel?.font = .boldSystemFont(ofSize: 30)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 65).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 100).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -100).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -375).isActive = true
        self.layer.cornerRadius = 15
    }
    
    
    
}
