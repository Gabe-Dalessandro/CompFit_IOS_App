//
//  RegisterViewController.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 2/5/21.
//

import UIKit


class SignUpViewController: UIViewController {
    
    private let profilePictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .label
        imageView.image = UIImage(systemName: "person.circle")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 45
        return imageView
    }()

    private let usernameField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = "Username"
        field.returnKeyType = .next
        field.autocorrectionType = .no
        return field
    }()
    
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
        field.placeholder = "Create Password"
        field.isSecureTextEntry = true
        field.keyboardType = .default
        field.returnKeyType = .continue
        field.autocorrectionType = .no
        return field
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = Constants.Colors.brandDarkGrey
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.poppinsRegular(size: 20)
        button.setTitleColor(Constants.Colors.brandElectricGreen, for: .normal)
        return button
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Create Account"
        
        addSubviews()
        
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        addImageGesture()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let imageSize: CGFloat = 90.0
        profilePictureImageView.frame = CGRect(x: (view.width - imageSize)/2, y: view.safeAreaInsets.top+15, width: imageSize, height: imageSize)
        
        usernameField.frame = CGRect(x: 25, y: profilePictureImageView.bottom + 20, width: view.width - 50, height: 50)
        
        emailField.frame = CGRect(x: 25, y: usernameField.bottom + 10, width: view.width - 50, height: 50)
        
        passwordField.frame = CGRect(x: 25, y: emailField.bottom + 10, width: view.width - 50, height: 50)
        
        signUpButton.frame = CGRect(x: 25, y: passwordField.bottom + 20, width: view.width - 50, height: 50)
    }
    
    

    private func addSubviews() {
        view.addSubview(profilePictureImageView)
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signUpButton)
    }
    
    
    private func addImageGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        profilePictureImageView.isUserInteractionEnabled = true
        profilePictureImageView.addGestureRecognizer(tap)
    }
    
    @objc private func didTapImage() {
        let sheet = UIAlertController(title: "Profile Picture", message: "Set a picture to help everyone discover you", preferredStyle: .actionSheet)
        
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        sheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { [weak self] _ in
            
            DispatchQueue.main.async {
                let pickerVC = UIImagePickerController()
                pickerVC.sourceType = .camera
                pickerVC.allowsEditing = true
                pickerVC.delegate = self
                self?.present(pickerVC, animated: true, completion: nil)
            }
        }))
        
        sheet.addAction(UIAlertAction(title: "Choose From Library", style: .default, handler: { [weak self] _ in
            
            DispatchQueue.main.async {
                let pickerVC = UIImagePickerController()
                pickerVC.allowsEditing = true
                pickerVC.sourceType = .photoLibrary
                pickerVC.delegate = self
                self?.present(pickerVC, animated: true, completion: nil)
            }
            
        }))
        
        
        present(sheet, animated: true, completion: nil)
    }
    
    @objc private func didTapSignUp() {
        // Dismiss the keyboard
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        // Check if: fields aren't empty,they aren't just filled with whitespaces,
            // username doesn't contain symbols, and check proper password strength
        guard let username = usernameField.text, let email = emailField.text, let password = passwordField.text,
              !username.trimmingCharacters(in: .whitespaces).isEmpty,
              username.trimmingCharacters(in: .alphanumerics).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 8
        else {
            presentError(errorMessage: "Field was left blank")
            return
        }
        
        // Register new user
        let newUser = UserModel(email: email, password: password)
        let errorMessage = RegisterNetworking.registerNewUser2(userData: newUser)
   
        if (errorMessage == "") {
            transitionToOnboarding()
        } else {
            presentError(errorMessage: errorMessage)
            return
        }
    }
    
    
    // Present the errors as an alert
    private func presentError(errorMessage: String) {
        let alert = UIAlertController(title: "Unsuccessful Sign Up", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    private func transitionToMainApp() {
        let mainTabBarController = MainTabBarController()
        mainTabBarController.viewControllers = []
        mainTabBarController.modalPresentationStyle = .fullScreen
        mainTabBarController.isModalInPresentation = false

        present(mainTabBarController, animated: true, completion: nil)
    }
    
    
    private func transitionToOnboarding() {

        let onboardingViewController = OnboardingViewController()
        onboardingViewController.modalPresentationStyle = .fullScreen
        onboardingViewController.emailStr = emailField.text!
        onboardingViewController.passwordStr = passwordField.text!
        onboardingViewController.phoneNumberStr = "5703325722"

        self.navigationController?.pushViewController(onboardingViewController, animated: true)
    }
    
}







extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == usernameField) {
            emailField.becomeFirstResponder()
        }
        else if (textField == emailField) {
            passwordField.becomeFirstResponder()
        }
        else if (textField == passwordField){
            textField.resignFirstResponder()
            didTapSignUp()
        }
        
        return true
    }
}



// Used to choose a profile picture for the account
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        profilePictureImageView.image = image
    }
}






