//
//  LoginViewController.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 2/5/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    var emailView = UIView()
    var passwordView = UIView()
    
    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    
    var loginButton = UIButton()
    
    //api route to login a user
    let loginUrlStr = "http://127.0.0.1:8000/api/user/login/"


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        setEmailView()
        setPasswordView()
        setLoginButton()
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
        //set the view in within the VC
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
    
    
    
    private func setLoginButton() {
        loginButton.backgroundColor = .systemOrange
        loginButton.setTitleColor(.systemTeal, for: .normal)
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = .boldSystemFont(ofSize: 30)
        
        self.view.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.heightAnchor.constraint(equalToConstant: 65).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 100).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -100).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -375).isActive = true
        loginButton.layer.cornerRadius = 15
        
        loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
    }
    
    
    
    @objc func loginPressed(recognizer: UITapGestureRecognizer) {

        emailTextField.text = "jsnow@gmail.com"
        passwordTextField.text = "fitness123"
        
        let email = emailTextField.text
        let password = passwordTextField.text
        
        if (email != "" && password != "") {
            loginUser(email!, password!)
        } else {
            print("no email entered")
        }
    }
    
    
    func loginUser(_ email: String, _ password: String) {
        let myGroup = DispatchGroup()
        myGroup.enter()
        
        var successfulLogin = false
        
        // Create the user and convert it JSON
        let user = UserModel(email: email, password: password)
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(user)


        //Construct the url for the api request
        guard let url = URL(string: loginUrlStr) else {fatalError()}
        var urlRequest = URLRequest(url: url)

        // Construct the request
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = jsonData

        //Create a URL Session
        let session = URLSession.shared.dataTask(with: urlRequest) {(data, response, error) in
            if (error != nil) {
                print("\n=== Error in LOGIN request 'user/login' ===")
                print(error!)
            } else {
                //ensure the response status is 200 OK and that there is data
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let validData = data else {
                        //completion(.failure(.responseProblem))
                    return
                }

                do {
                    let loggedInUser = try JSONDecoder().decode(UserModel.self, from: validData)
//                    print("\nResponse data: \(loggedInUser)")
                    
                    UserDefaults.standard.setIsLoggedIn(value: true)
                    UserDefaults.standard.setCurrentUser(loggedInUser, writeToUserDefaults: true)
                    
                    let currentUser = UserDefaults.standard.getCurrentUser()
                    print("\n\n=== Login Successful! ===")
                    print("Logged In User: \t\(currentUser)")
                    successfulLogin = true
                    myGroup.leave()
                } catch {
                    print("\n\n=== Error in LOGIN request 'user/login' ===")
                    successfulLogin = false
                    myGroup.leave()
                }
            }
        }
        session.resume()
        
        myGroup.notify(queue: .main) {
            if successfulLogin {
                self.transitionToMainApp()
            } else {
                print("Error logging in")
            }
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
            if(emailTextField.isEditing) {
                textField.placeholder = "Enter email!"
            } else if (passwordTextField.isEditing) {
                textField.placeholder = "Enter password!"
            }

            return false;
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(emailTextField.isEditing) {
            emailTextField.endEditing(true);
            return false;
        } else if (passwordTextField.isEditing) {
            passwordTextField.endEditing(true);
            return false;
        }

        return true;
    }
}
